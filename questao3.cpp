#include <bits/stdc++.h>

using namespace std;

#define T_EOL 0
#define T_CONST 10
#define T_ID 20
#define T_OP 30

string ops = "+-*/\0";

int checkpos(string str, int pos){
    while(str[pos] == ' '){
        pos++;
    }
    return pos;
}

int lexica(string str, int * pos){
    while(str[*pos] == ' '){
        (*pos)++;
    }
    int ini = *pos;

    while(str[*pos] >= '0' and str[*pos] <= '9'){
        (*pos)++;
    }
    if(ini != *pos) {
      return T_CONST;
    }

    for(char c : ops){
        if(str[*pos] == c) (*pos)++;
    }
    if(ini != *pos) {
      return T_OP;
    }

    if((str[*pos] >= 'A' and str[*pos] <= 'Z') or (str[*pos] >= 'a' and str[*pos] <= 'z')){
      while((str[*pos] >= 'A' and str[*pos] <= 'Z') or (str[*pos] >= 'a' and str[*pos] <= 'z') or (str[*pos] >= '0' and str[*pos] <= '9')){
        (*pos)++;
      }
    }

    if(ini != *pos){
      return T_ID;
    }

    if(str[*pos] == '\0') return T_EOL;

}

int main(){

    string in;
    getline(cin, in);
    int i = 0;
    while(i < in.size()-1){
        int a = lexica(in, &i);
        switch(a){
          case T_ID:
          cout << "ID" << endl;
          break;

          case T_CONST:
          cout << "CONST" << endl;
          break;

          case T_OP:
          cout << "OPERATOR" << endl;
          break;

          case T_EOL:
          break;
        }
    }

    return 0;

}
