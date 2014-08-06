DROP PROCEDURE IF EXISTS sync_cover_checksum_oclc;

###########################
# Sync by OCLC
###########################

delimiter //

CREATE PROCEDURE sync_cover_checksum_oclc()
BEGIN
    DECLARE id_sync, id_sync_param, id_sync_param_remove, id_inst INT;
    DECLARE done INT DEFAULT FALSE;

    #create sync event
    DECLARE sync_cursor CURSOR FOR
    SELECT sp.id, inst.id
      FROM obalky.cover_checksum AS ch
           INNER JOIN obalky.cover AS c
                   ON c.id = ch.id
                  AND c.checksum != ch.checksum
           INNER JOIN obalky.book AS b
                   ON b.id = ch.book
           INNER JOIN obalky.fe_sync_param AS sp
                   ON sp.param_name = 'oclc'
                  AND sp.param_value = b.oclc
           INNER JOIN obalky.fe_list AS inst
     WHERE IFNULL(b.oclc, '') != ''
       AND IFNULL(b.ean13, '') = ''
       AND IFNULL(b.nbn, '') = ''
       AND inst.flag_active = 1
     GROUP BY b.oclc;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SELECT id INTO @id_sync_param_remove FROM fe_sync_param WHERE param_name = 'remove' AND param_value = 'true';

    OPEN sync_cursor;
    get_sync: LOOP
        FETCH sync_cursor INTO id_sync_param, id_inst;

        IF done THEN
            LEAVE get_sync;
        END IF;

        # create sync record
        INSERT INTO fe_sync (fe_instance, fe_sync_type) VALUES (id_inst, 1);
        SET @id_sync = LAST_INSERT_ID();
        INSERT INTO fe_sync2param (id_sync, id_sync_param) VALUES (@id_sync, id_sync_param), (@id_sync, @id_sync_param_remove);

    END LOOP get_sync;
    CLOSE sync_cursor;
END;
//

#CALL sync_cover_checksum_oclc();