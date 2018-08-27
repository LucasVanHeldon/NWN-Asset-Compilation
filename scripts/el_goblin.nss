#include "encounter"
#include "nw_o0_itemmaker"

void main()
{
    float CR = GetChallengeRating(OBJECT_SELF);
    int   EL = CalcEL(OBJECT_SELF);
    int   num = FloatToInt(CalcNumFromELCR(EL,CR));
    string sTag = GetLocalArrayString(OBJECT_SELF,"Tags",Random(GetLocalInt(OBJECT_SELF,"nNum")));
    int i;
    int n = FloatToInt(CR);


    sTag = GetLocalArrayString(OBJECT_SELF,"Tags", Random(GetLocalInt(OBJECT_SELF,"nNum")));

    for(i = 0; i < num; i++)
    {
        object o = CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(OBJECT_SELF));
        AssignCommand(o,ActionRandomWalk());
    }


    DestroyObject(OBJECT_SELF);

}
