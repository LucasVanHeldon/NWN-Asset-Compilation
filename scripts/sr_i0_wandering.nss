void WandMonCheck(object oPC, int iDoor=FALSE)
{
    object oArea = GetArea(oPC);
    int iUnsafe = GetLocalInt(oArea, "Unsafe");
    int iChance = GetLocalInt(oArea, "Chance");

//    FloatingTextStringOnCreature(GetName(oPC) + ": Unsafe = " + IntToString(iUnsafe) + " & Chance = " + IntToString(iChance), oPC);
    // Wandering Monster?
    if (iUnsafe > 0) {
        int iRoll = Random(iChance)+1;
//        if (iDoor)
//            iRoll += Random(iChance);
        if (iRoll == 1 && iChance > 0) {
//              FloatingTextStringOnCreature(GetName(oPC) + "'s snoring has attracted a wandering monster!", oPC);
            AssignCommand(oPC, ClearAllActions());
            SetCommandable(TRUE, oPC);
            // Generate Monster
            int iType = d4();
            object oEnemy;
            int iDirection=d4();
            float fX;
            float fY;
            switch(iDirection)
            {
                case 1: fX=0.0; fY=10.0; break;
                case 2: fX=10.0; fY=0.0; break;
                case 3: fX=0.0; fY=-10.0; break;
                case 4: fX=-10.0; fY=0.0; break;
            }
            vector vStart = GetPosition(oPC);
            vector vOffset = Vector(fX,fY);
            vector vEndvector=vStart+vOffset;
            location lHere=Location(oArea, vEndvector, GetFacing(oPC));
            int iNumb = 0;

            string sResRef = GetLocalString(oArea, "RR" + IntToString(iType));
            int iRR = GetLocalInt(oArea, "nRR" + IntToString(iType));
            while (iNumb < iRR) {
                oEnemy = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lHere, FALSE);
                AssignCommand(oEnemy, ActionAttack(oPC));
                iNumb ++;
            }
        }
    } // iUnsafe
}


