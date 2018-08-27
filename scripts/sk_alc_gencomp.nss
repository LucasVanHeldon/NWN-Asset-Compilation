#include "sk_alc_gencmpinc"

void Reset(object oSelf)
{
    SetLocalInt(oSelf,"NW_DO_ONCE",0);
    DelayCommand(300.0,Reset(oSelf));
}

void main()
{
    string sComp = GenerateAlchemyComponent();
    int i = d4();
    while(i-->0){
        CreateItemOnObject(sComp);
    }
    DelayCommand(60.0,Reset(OBJECT_SELF));

}
