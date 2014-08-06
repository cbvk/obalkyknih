DROP PROCEDURE IF EXISTS sync_be2fe_book;

####################################################
# Update param codelist and run sync cursors which
# which will create sync event
####################################################

delimiter //

CREATE PROCEDURE sync_be2fe_book()
BEGIN

    # remove=true param
    INSERT IGNORE INTO fe_sync_param (param_name, param_value) VALUES ('remove', 'true');

    # update param codelist by EAN
    INSERT INTO obalky.fe_sync_param (param_name, param_value)
    SELECT 'isbn', b.ean13
      FROM obalky.be2fe_book AS bnew
           INNER JOIN obalky.book AS b
                   ON b.id = bnew.id
                  AND b.cover != bnew.cover
           LEFT OUTER JOIN obalky.fe_sync_param AS sp
                   ON sp.param_name = 'isbn'
                  AND sp.param_value = b.ean13
     WHERE IFNULL(b.ean13, '') != ''
       AND sp.id IS NULL
     GROUP BY b.ean13;

    # update param codelist by NBN
    INSERT INTO obalky.fe_sync_param (param_name, param_value)
    SELECT 'nbn', b.nbn
      FROM obalky.be2fe_book AS bnew
           INNER JOIN obalky.book AS b
                   ON b.id = bnew.id
                  AND b.cover != bnew.cover
           LEFT OUTER JOIN obalky.fe_sync_param AS sp
                   ON sp.param_name = 'nbn'
                  AND sp.param_value = b.nbn
     WHERE IFNULL(b.nbn, '') != ''
       AND IFNULL(b.ean13, '') = ''
       AND sp.id IS NULL
     GROUP BY b.nbn;

    # update param codelist by OCLC
    INSERT INTO obalky.fe_sync_param (param_name, param_value)
    SELECT 'oclc', b.oclc
      FROM obalky.be2fe_book AS bnew
           INNER JOIN obalky.book AS b
                   ON b.id = bnew.id
                  AND b.cover != bnew.cover
           LEFT OUTER JOIN obalky.fe_sync_param AS sp
                   ON sp.param_name = 'oclc'
                  AND sp.param_value = b.oclc
     WHERE IFNULL(b.oclc, '') != ''
       AND IFNULL(b.nbn, '') = ''
       AND IFNULL(b.ean13, '') = ''
       AND sp.id IS NULL
     GROUP BY b.oclc;

    CALL sync_be2fe_book_ean();
    CALL sync_be2fe_book_nbn();
    CALL sync_be2fe_book_oclc();
END;
//
