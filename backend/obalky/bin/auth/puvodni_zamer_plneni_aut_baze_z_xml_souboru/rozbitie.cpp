#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <sstream>

using namespace std;

#define SIZE 50000


namespace patch
{
    template < typename T > std::string to_string( const T& n )
    {
        std::ostringstream stm ;
        stm << n ;
        return stm.str() ;
    }
}


int main()
{
    string s;
    bool zaciatok = true;
    vector<string> uvod;
    string zaver = "</collection>";

    int c = 0;

    ifstream infile;
    infile.open("aut_exp.xml");

    ofstream outfile;
    int cislo = 1;
    string name = "aut_"+patch::to_string(cislo)+".xml";
    outfile.open(name.c_str());

    bool otvorene = true;

    while(!infile.eof()){

        getline(infile, s);

        if(zaciatok && s != "<record>"){
            uvod.push_back(s);
        }else{
            zaciatok = false;
        }

        if(s == "<record>"){
            if(!outfile.is_open()){
                //otvori novy
                cislo++;
                string name = "aut_"+patch::to_string(cislo)+".xml";
                outfile.open(name.c_str());

                for(int i=0; i<uvod.size(); i++){
                    outfile << uvod[i] << endl;
                }
            }
            outfile << s << endl;
            otvorene = true;
        }
        else if(s == "</record>"){
            outfile << s << endl;
            otvorene = false;
            c++;
            if(c % SIZE == 0){
                //stary
                outfile << zaver << endl;
                outfile.close();
            }
        }else if(otvorene){
            outfile << s << endl;
        }

    }

    infile.close();
    if(outfile.is_open()){
        outfile << zaver << endl;
        outfile.close();
    }

    for(int i=0; i<uvod.size(); i++){
        cout << uvod[i] << endl;
    }
    cout << zaver << endl;

    return 0;
}

