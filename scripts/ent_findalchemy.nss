#include "x0_i0_secret"
#include "inc_detectsecret"

void CreateReagent()
{
    int n = d20();

    string s = "acomp_0";
    if(n < 10) s = s + "0";
    s = s + IntToString(n);
    CreateObject(OBJECT_TYPE_ITEM,s,GetLocation(OBJECT_SELF));
}

void CreateReagents(int n)
{
    int i;
    for(i = 0; i < n; i++) CreateReagent();
}

void main()
{
    object oC = GetEnteringObject();

    if(GetIsPC(oC))
    {
        object oMushroom = GetNearestObjectByTag("mushrooms");
        if(DetectSecretItem(oMushroom))
        {
            SendMessageToPC(oC,"You have found something.");
            CreateReagents(d6());
         }
    }

}

