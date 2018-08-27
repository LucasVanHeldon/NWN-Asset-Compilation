// all the standard game magic items

void CreateStdScroll1()
{
     object oSack = OBJECT_SELF;
     string sType;
     int nRandom = Random(16) + 1;
     int iRoll;


     iRoll = d100();
     switch (iRoll)
        {
        case 1: sType = "x1_it_sparscr002";break;
        case 2: sType = "nw_it_sparscr107";break;
        case 3: sType = "x1_it_sparscr102";break;
        case 4: sType = "x1_it_spdvscr101";break;
        case 5: sType = "x2_it_spdvscr202";break;
        case 6: sType = "x2_it_spdvscr103";break;
        case 7: sType = "x2_it_spdvscr102";break;
        case 8: sType = "nw_it_sparscr211";break;
        case 9: sType = "x1_it_spdvscr202";break;
        case 10: sType = "nw_it_sparscr212";break;
        case 11: sType = "nw_it_sparscr112";break;
        case 12: sType = "x1_it_spdvscr107";break;
        case 13: sType = "nw_it_sparscr213";break;
        case 14: sType = "x2_it_sparscr207";break;
        case 15: sType = "nw_it_sparscr107";break;
        case 16: sType = "nw_it_spdvscr202";break;
        case 17: sType = "nw_it_sparscr217";break;
        case 18: sType = "x2_it_sparscr206";break;
        case 19: sType = "nw_it_sparscr110";break;
        case 20: sType = "x2_it_sparscr201";break;
        case 21: sType = "x1_it_spdvscr301";break;
        case 22: sType = "x2_it_spdvscr104";break;
        case 23: sType = "x2_it_spdvscr001";break;
        case 24: sType = "x2_it_spdvscr203";break;
        case 25: sType = "x2_it_spdvscr308";break;
        case 26: sType = "nw_it_sparscr206";break;
        case 27: sType = "nw_it_sparscr003";break;
        case 28: sType = "x2_it_spdvscr101";break;
        case 29: sType = "x2_it_sparscr202";break;
        case 30: sType = "x1_it_spdvscr102";break;
        case 31: sType = "x2_it_spdvscr105";break;
        case 32: sType = "nw_it_sparscr219";break;
        case 33: sType = "x1_it_sparscr003";break;
        case 34: sType = "nw_it_sparscr215";break;
        case 35: sType = "nw_it_sparscr101";break;
        case 36: sType = "x2_it_spdvscr106";break;
        case 37: sType = "x1_it_spdvscr103";break;
        case 38: sType = "x1_it_sparscr101";break;
        case 39: sType = "x1_it_sparscr101";break;
        case 40: sType = "x2_it_sparscr305";break;
        case 41: sType = "x1_it_spdvscr205";break;
        case 42: sType = "x2_it_sparscr205";break;
        case 43: sType = "x1_it_sparscr001";break;
        case 44: sType = "nw_it_sparscr220";break;
        case 45: sType = "x2_it_sparscr203";break;
        case 46: sType = "nw_it_sparscr208";break;
        case 47: sType = "nw_it_sparscr209";break;
        case 48: sType = "nw_it_sparscr103";break;
        case 49: sType = "x2_it_spdvscr204";break;
        case 50: sType = "nw_it_sparscr308";break;
        case 51: sType = "x2_it_sparscr101";break;
        case 52: sType = "x2_it_sparscr104";break;
        case 53: sType = "nw_it_sparscr106";break;
        case 54: sType = "x1_it_spdvscr104";break;
        case 55: sType = "x1_it_spdvscr001";break;
        case 56: sType = "x1_it_spdvscr201";break;
        case 57: sType = "nw_it_sparscr207";break;
        case 58: sType = "x2_it_sparscr102";break;
        case 59: sType = "nw_it_sparscr216";break;
        case 60: sType = "nw_it_sparscr218";break;
        case 61: sType = "nw_it_spdvscr201";break;
        case 62: sType = "nw_it_sparscr004";break;
        case 63: sType = "nw_it_sparscr104";break;
        case 64: sType = "x1_it_spdvscr106";break;
        case 65: sType = "nw_it_sparscr109";break;
        case 66: sType = "x2_it_sparscr105";break;
        case 67: sType = "nw_it_sparscr202";break;
        case 68: sType = "nw_it_sparscr113";break;
        case 69: sType = "x1_it_spdvscr203";break;
        case 70: sType = "nw_it_sparscr221";break;
        case 71: sType = "nw_it_sparscr102";break;
        case 72: sType = "x2_it_sparscral";break;
        case 73: sType = "nw_it_sparscr111";break;
        case 74: sType = "nw_it_sparscr002";break;
        case 75: sType = "x2_it_spdvscr107";break;
        case 76: sType = "x2_it_spdvscr205";break;
        case 77: sType = "nw_it_sparscr201";break;
        case 78: sType = "nw_it_sparscr001";break;
        case 79: sType = "x2_it_spdvscr108";break;
        case 80: sType = "nw_it_sparscr210";break;
        case 81: sType = "x2_it_sparscr103";break;
        case 82: sType = "x1_it_sparscr103";break;
        case 83: sType = "x1_it_spdvscr105";break;
        case 84: sType = "nw_it_spdvscr203";break;
        case 85: sType = "nw_it_sparscr108";break;
        case 86: sType = "nw_it_spdvscr204";break;
        case 87: sType = "x2_it_sparscr204";break;
        case 88: sType = "nw_it_sparscr105";break;
        case 89: sType = "nw_it_sparscr203";break;
        case 90: sType = "x1_it_sparscr202";break;
        case 91: sType = "x1_it_sparscr104";break;
        case 92: sType = "nw_it_sparscr214";break;
        case 93: sType = "x2_it_spdvscr002";break;
        case 94: sType = "nw_it_sparscr204";break;
       }

    object oScroll =  CreateItemOnObject(sType, oSack, 1);
    itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
    IPSafeAddItemProperty(oScroll,ipAdd);
    ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_SORCERER);
    IPSafeAddItemProperty(oScroll,ipAdd);
    ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_WIZARD);
    IPSafeAddItemProperty(oScroll,ipAdd);

    SetIdentified(oScroll, TRUE);

}

void CreateStdScroll2()
{
     object oSack = OBJECT_SELF;
     string sType;
     int nRandom = Random(16) + 1;
     int iRoll;

     iRoll = d100();    /// scrolls valued 540-1621
     switch (iRoll)
        {
        case 1: sType = "nw_it_sparscr509";break;
        case 2: sType = "x2_it_spdvscr508";break;
        case 3: sType = "x2_it_sparscr501";break;
        case 4: sType = "x2_it_spdvscr501";break;
        case 5: sType = "nw_it_sparscr414";break;
        case 6: sType = "x1_it_sparscr502";break;
        case 7: sType = "x2_it_spdvscr307";break;
        case 8: sType = "nw_it_sparscr405";break;
        case 9: sType = "x2_it_spdvscr504";break;
        case 10: sType = "nw_it_sparscr307";break;
        case 11: sType = "nw_it_sparscr502";break;
        case 12: sType = "nw_it_sparscr507";break;
        case 13: sType = "nw_it_sparscr406";break;
        case 14: sType = "nw_it_sparscr411";break;
        case 15: sType = "x2_it_spdvscr402";break;
        case 16: sType = "x2_it_spdvscr305";break;
        case 17: sType = "x2_it_spdvscr403";break;
        case 18: sType = "nw_it_sparscr501";break;
        case 19: sType = "nw_it_sparscr301";break;
        case 20: sType = "x1_it_sparscr301";break;
        case 21: sType = "x2_it_spdvscr404";break;
        case 22: sType = "x2_it_spdvscr309";break;
        case 23: sType = "nw_it_sparscr416";break;
        case 24: sType = "nw_it_sparscr503";break;
        case 25: sType = "nw_it_sparscr608";break;
        case 26: sType = "nw_it_sparscr418";break;
        case 27: sType = "x2_it_spdvscr509";break;
        case 28: sType = "nw_it_sparscr413";break;
        case 29: sType = "nw_it_sparscr504";break;
        case 30: sType = "nw_it_sparscr309";break;
        case 31: sType = "x1_it_sparscr501";break;
        case 32: sType = "nw_it_sparscr304";break;
        case 33: sType = "x1_it_spdvscr403";break;
        case 34: sType = "x2_it_spdvscr405";break;
        case 35: sType = "x2_it_spdvscr306";break;
        case 36: sType = "x2_it_sparscr701";break;
        case 37: sType = "nw_it_sparscr602";break;
        case 38: sType = "x1_it_spdvscr303";break;
        case 39: sType = "x2_it_sparscr304";break;
        case 40: sType = "nw_it_sparscr508";break;
        case 41: sType = "x1_it_sparscr303";break;
        case 42: sType = "x2_it_spdvscr406";break;
        case 43: sType = "nw_it_sparscr312";break;
        case 44: sType = "x2_it_spdvscr505";break;
        case 45: sType = "x2_it_spdvscr302";break;
        case 46: sType = "nw_it_sparscr505";break;
        case 47: sType = "x2_it_spdvscr401";break;
        case 48: sType = "nw_it_sparscr408";break;
        case 49: sType = "x1_it_spdvscr501";break;
        case 50: sType = "x2_it_spdvscr301";break;
        case 51: sType = "x1_it_spdvscr401";break;
        case 52: sType = "x1_it_spdvscr302";break;
        case 53: sType = "x2_it_spdvscr310";break;
        case 54: sType = "nw_it_sparscr314";break;
        case 55: sType = "x1_it_sparscr401";break;
        case 56: sType = "x2_it_sparscr303";break;
        case 57: sType = "x2_it_sparscr602";break;
        case 58: sType = "nw_it_sparscr511";break;
        case 59: sType = "nw_it_sparscr512";break;
        case 60: sType = "nw_it_sparscr417";break;
        case 61: sType = "nw_it_sparscr513";break;
        case 62: sType = "nw_it_sparscr310";break;
        case 63: sType = "nw_it_sparscr302";break;
        case 64: sType = "x2_it_sparscrmc";break;
        case 65: sType = "x2_it_spdvscr304";break;
        case 66: sType = "x1_it_spdvscr402";break;
        case 67: sType = "x2_it_sparscr301";break;
        case 68: sType = "x2_it_sparscr502";break;
        case 69: sType = "nw_it_sparscr506";break;
        case 70: sType = "nw_it_sparscr401";break;
        case 71: sType = "x2_it_spdvscr502";break;
        case 72: sType = "nw_it_sparscr315";break;
        case 73: sType = "x2_it_spdvscr311";break;
        case 74: sType = "nw_it_spdvscr402";break;
        case 75: sType = "x1_it_spdvscr502";break;
        case 76: sType = "nw_it_sparscr409";break;
        case 77: sType = "x2_it_spdvscr407";break;
        case 78: sType = "nw_it_sparscr415";break;
        case 79: sType = "x2_it_spdvscr312";break;
        case 80: sType = "x1_it_spdvscr305";break;
        case 81: sType = "nw_it_spdvscr501";break;
        case 82: sType = "nw_it_spdvscr301";break;
        case 83: sType = "nw_it_sparscr402";break;
        case 84: sType = "nw_it_spdvscr401";break;
        case 85: sType = "x2_it_sparscr302";break;
        case 86: sType = "nw_it_sparscr410";break;
        case 87: sType = "x2_it_spdvscr506";break;
        case 88: sType = "nw_it_sparscr313";break;
        case 89: sType = "x2_it_spdvscr507";break;
        case 90: sType = "x1_it_spdvscr304";break;
        case 91: sType = "nw_it_sparscr305";break;
        case 92: sType = "nw_it_sparscr403";break;
        case 93: sType = "nw_it_sparscr306";break;
        case 94: sType = "nw_it_sparscr404";break;
        case 95: sType = "nw_it_sparscr510";break;
        case 96: sType = "x2_it_sparscr902";break;
        case 97: sType = "nw_it_sparscr606";break;
        case 98: sType = "x2_it_spdvscr503";break;
        case 99: sType = "nw_it_sparscr407";break;
        case 100: sType = "x1_it_sparscr302";break;
       }

    object oScroll =  CreateItemOnObject(sType, oSack, 1);
    itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
    IPSafeAddItemProperty(oScroll,ipAdd);

    SetIdentified(oScroll, TRUE);

}


void CreateStdScroll3()
{
     object oSack = OBJECT_SELF;
     string sType;
     int nRandom = Random(16) + 1;
     int iRoll;
    iRoll = d100();// scrolls valued 2400-3200
    switch (iRoll)
    {
    case 1: sType = "nw_it_sparscr603";break;
    case 2: sType = "x1_it_spdvscr701";break;
    case 3: sType = "x1_it_spdvscr601";break;
    case 4: sType = "x1_it_sparscr602";break;
    case 5: sType = "x1_it_sparscr701";break;
    case 6: sType = "x2_it_spdvscr603";break;
    case 7: sType = "nw_it_sparscr607";break;
    case 8: sType = "nw_it_sparscr610";break;
    case 9: sType = "nw_it_sparscr707";break;
    case 10: sType = "x1_it_spdvscr605";break;
    case 11: sType = "x1_it_spdvscr702";break;
    case 12: sType = "x2_it_spdvscr601";break;
    case 13: sType = "nw_it_sparscr704";break;
    case 14: sType = "x1_it_spdvscr703";break;
    case 15: sType = "x1_it_sparscr601";break;
    case 16: sType = "x1_it_spdvscr604";break;
    case 17: sType = "x2_it_sparscr503";break;
    case 18: sType = "nw_it_sparscr708";break;
    case 19: sType = "x1_it_spdvscr704";break;
    case 20: sType = "x1_it_sparscr605";break;
    case 21: sType = "nw_it_sparscr601";break;
    case 22: sType = "nw_it_spdvscr701";break;
    case 23: sType = "x1_it_spdvscr602";break;
    case 24: sType = "x2_it_spdvscr606";break;
    case 25: sType = "nw_it_sparscr612";break;
    case 26: sType = "nw_it_sparscr613";break;
    case 27: sType = "x2_it_spdvscr604";break;
    case 28: sType = "x2_it_spdvscr605";break;
    case 29: sType = "x1_it_sparscr603";break;
    case 30: sType = "nw_it_sparscr611";break;
    case 31: sType = "x1_it_spdvscr603";break;
    case 32: sType = "nw_it_sparscr604";break;
    case 33: sType = "nw_it_sparscr702";break;
    case 34: sType = "nw_it_sparscr706";break;
    case 35: sType = "nw_it_sparscr802";break;
    case 36: sType = "x2_it_spdvscr702";break;
    case 37: sType = "nw_it_spdvscr702";break;
    case 38: sType = "nw_it_sparscr609";break;
    case 39: sType = "x2_it_sparscr703";break;
    case 40: sType = "nw_it_sparscr701";break;
    case 41: sType = "x1_it_sparscr604";break;
    case 42: sType = "x2_it_spdvscr602";break;
    case 43: sType = "nw_it_sparscr605";break;
    case 44: sType = "nw_it_sparscr703";break;
    case 45: sType = "x2_it_spdvscr803";break;
    case 46: sType = "nw_it_sparscr614";break;
    case 47: sType = "nw_it_sparscr614";break;
    case 48: sType = "x2_it_sparscr601";break;
    case 49: sType = "x2_it_spdvscr701";break;
    case 50: sType = "nw_it_sparscr603";break;
    case 51: sType = "x1_it_spdvscr701";break;
    case 52: sType = "x1_it_spdvscr601";break;
    case 53: sType = "x1_it_sparscr602";break;
    case 54: sType = "x1_it_sparscr701";break;
    case 55: sType = "x2_it_spdvscr603";break;
    case 56: sType = "nw_it_sparscr607";break;
    case 57: sType = "nw_it_sparscr610";break;
    case 58: sType = "nw_it_sparscr707";break;
    case 59: sType = "x1_it_spdvscr605";break;
    case 60: sType = "x1_it_spdvscr702";break;
    case 61: sType = "x2_it_spdvscr601";break;
    case 62: sType = "nw_it_sparscr704";break;
    case 63: sType = "x1_it_spdvscr703";break;
    case 64: sType = "x1_it_sparscr601";break;
    case 65: sType = "x1_it_spdvscr604";break;
    case 66: sType = "x2_it_sparscr503";break;
    case 67: sType = "nw_it_sparscr708";break;
    case 68: sType = "x1_it_spdvscr704";break;
    case 69: sType = "x1_it_sparscr605";break;
    case 70: sType = "nw_it_sparscr601";break;
    case 71: sType = "nw_it_spdvscr701";break;
    case 72: sType = "x1_it_spdvscr602";break;
    case 73: sType = "x2_it_spdvscr606";break;
    case 74: sType = "nw_it_sparscr612";break;
    case 75: sType = "nw_it_sparscr613";break;
    case 76: sType = "x2_it_spdvscr604";break;
    case 77: sType = "x2_it_spdvscr605";break;
    case 78: sType = "x1_it_sparscr603";break;
    case 79: sType = "nw_it_sparscr611";break;
    case 80: sType = "x1_it_spdvscr603";break;
    case 81: sType = "nw_it_sparscr604";break;
    case 82: sType = "nw_it_sparscr702";break;
    case 83: sType = "nw_it_sparscr706";break;
    case 84: sType = "nw_it_sparscr802";break;
    case 85: sType = "x2_it_spdvscr702";break;
    case 86: sType = "nw_it_spdvscr702";break;
    case 87: sType = "nw_it_sparscr609";break;
    case 88: sType = "x2_it_sparscr703";break;
    case 89: sType = "nw_it_sparscr701";break;
    case 90: sType = "x1_it_sparscr604";break;
    case 91: sType = "x2_it_spdvscr602";break;
    case 92: sType = "nw_it_sparscr605";break;
    case 93: sType = "nw_it_sparscr703";break;
    case 94: sType = "x2_it_spdvscr803";break;
    case 95: sType = "nw_it_sparscr614";break;
    case 96: sType = "nw_it_sparscr614";break;
    case 97: sType = "x2_it_sparscr601";break;
    case 98: sType = "x2_it_spdvscr701";break;
    case 99: sType = "x2_it_sparscr703";break;
    case 100: sType = "nw_it_sparscr701";break;
   }
    object oScroll =  CreateItemOnObject(sType, oSack, 1);
    itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
    IPSafeAddItemProperty(oScroll,ipAdd);

    SetIdentified(oScroll, TRUE);

}

void CreateStdScroll4()
{
     object oSack = OBJECT_SELF;
     string sType;
     int nRandom = Random(16) + 1;
     int iRoll;


    iRoll = Random(40)+1;     // scrolls valued above 3200
    switch (iRoll)
    {
    case 1: sType = "nw_it_sparscr806";
    case 2: sType = "x2_it_spdvscr804";
    case 3: sType = "x1_it_sparscr801";
    case 4: sType = "x1_it_sparscr901";
    case 5: sType = "x2_it_sparscr901";
    case 6: sType = "x2_it_sparscr801";
    case 7: sType = "x1_it_spdvscr803";
    case 8: sType = "x1_it_spdvscr804";
    case 9: sType = "nw_it_sparscr905";
    case 10: sType = "x2_it_spdvscr901";
    case 11: sType = "nw_it_sparscr908";
    case 12: sType = "nw_it_sparscr902";
    case 13: sType = "nw_it_sparscr803";
    case 14: sType = "nw_it_sparscr912";
    case 15: sType = "nw_it_sparscr809";
    case 16: sType = "x2_it_spdvscr902";
    case 17: sType = "nw_it_sparscr804";
    case 18: sType = "nw_it_sparscr807";
    case 19: sType = "nw_it_sparscr806";
    case 20: sType = "x2_it_spdvscr801";
    case 21: sType = "nw_it_sparscr906";
    case 22: sType = "nw_it_sparscr801";
    case 23: sType = "nw_it_sparscr901";
    case 24: sType = "x2_it_spdvscr802";
    case 25: sType = "nw_it_sparscr903";
    case 26: sType = "nw_it_sparscr808";
    case 27: sType = "nw_it_sparscr910";
    case 28: sType = "x2_it_spdvscr903";
    case 29: sType = "nw_it_sparscr904";
    case 30: sType = "nw_it_sparscr805";
    case 31: sType = "x1_it_spdvscr802";
    case 32: sType = "nw_it_sparscr911";
    case 33: sType = "x1_it_spdvscr901";
    case 34: sType = "nw_it_sparscr909";
    case 35: sType = "nw_it_sparscr907";
    case 36: sType = "x1_it_spdvscr801";
    case 37: sType = "nw_it_sparscr906";
    case 38: sType = "nw_it_sparscr808";
    case 39: sType = "x2_it_sparscr801";
    case 40: sType = "x2_it_spdvscr804";
   }

    object oScroll =  CreateItemOnObject(sType, oSack, 1);
    itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
    IPSafeAddItemProperty(oScroll,ipAdd);
    SetIdentified(oScroll, TRUE);
}

void CreateStdScroll()
{


    switch(d2())
    {
    case 1: CreateArcaneScroll(OBJECT_SELF,OBJECT_SELF); break;
    case 2: CreateDivineScroll(OBJECT_SELF,OBJECT_SELF); break;
    }
}


/****************************************************************
 Potions
 ****************************************************************/

void CreateHealingPotion()
{
    string sPotion;
    switch(Die(6))
    {
    case 1: sPotion="nw_it_mpotion003"; break;
    case 2: sPotion="nw_it_mpotion001"; break;
    case 3: sPotion="nw_it_mpotion020"; break;
    case 4: sPotion="nw_it_mpotion002"; break;
    case 5: sPotion="nw_it_mpotion012"; break;
    case 6: sPotion="nw_it_mpotion011"; break;
    }
    object o = CreateItemOnObject(sPotion,OBJECT_SELF,1);
    object oItem = CreateItemOnObject(sPotion,OBJECT_SELF,1);
    object oldItem=oItem;
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oItem)) DestroyObject(oldItem);
}

void CreateStdPotion()
{
    object oSack = OBJECT_SELF;
    string sPotion;


    if(d6() < 3) CreateHealingPotion();
    else
    {
        int nRandom = Random(23) + 1;
        switch (nRandom)
        {
            case 1:sPotion = "x2_it_mpotion001";  break;
            case 2:sPotion = "x2_it_mpotion002";  break;
            case 3: sPotion = "nw_it_mpotion001" ; break;
            case 4: sPotion = "nw_it_mpotion002" ; break;
            case 5: sPotion = "nw_it_mpotion003" ; break;
            case 6: sPotion = "nw_it_mpotion004" ; break;
            case 7: sPotion = "nw_it_mpotion005" ; break;
            case 8: sPotion = "nw_it_mpotion006";  break;
            case 9: sPotion = "nw_it_mpotion007";  break;
            case 10: sPotion = "nw_it_mpotion008";  break;
            case 11: sPotion = "nw_it_mpotion009";  break;
            case 12: sPotion = "nw_it_mpotion010";  break;
            case 13: sPotion = "nw_it_mpotion011";  break;
            case 14: sPotion = "nw_it_mpotion012";  break;
            case 15: sPotion = "nw_it_mpotion013";  break;
            case 16: sPotion = "nw_it_mpotion014";  break;
            case 17: sPotion = "nw_it_mpotion015";  break;
            case 18: sPotion = "nw_it_mpotion016";  break;
            case 19: sPotion = "nw_it_mpotion017";  break;
            case 20: sPotion = "nw_it_mpotion018";  break;
            case 21: sPotion = "nw_it_mpotion019";  break;
            case 22: sPotion = "nw_it_mpotion020";  break;
            case 23: sPotion = "x2_it_mpotion001";  break;
        }
        object oItem = CreateItemOnObject(sPotion,OBJECT_SELF,1);
        object oldItem=oItem;
        oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
        if(GetIsObjectValid(oItem)) DestroyObject(oldItem);


    }
}

