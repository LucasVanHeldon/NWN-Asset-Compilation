#include "bm_po_inc"

void main()
{

   int iSpellID = GetLastSpell();
   object oPlayer = GetLastSpellCaster();
   int iCost;
   int nXP = GetXP(oPlayer);
   int nXPCost;
   int iSpellLevel;
   int iCastLevel;
   int nTime;
   string sPotionTag;
   int iSuccess;
   int nHD = GetHitDice ( oPlayer );
   int nMinXP = ((( nHD * ( nHD - 1) ) / 2 ) * 1000) + 1; //Minimum amount of XP needed to keep level

   object oBottle = GetItemPossessedBy(OBJECT_SELF, "NW_IT_THNMISC001");
   object oMod = GetModule();
   string sPCName = GetName(oPlayer);
   string sCDK = GetPCPublicCDKey(oPlayer);


   if (oBottle == OBJECT_INVALID)
        return;

   switch (iSpellID)
   {
        case SPELL_AID:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION016";
              iCastLevel = 3;
              break;
        case SPELL_NEUTRALIZE_POISON:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION006";
              iCastLevel = 5;
              break;
        case SPELL_BARKSKIN:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION005";
              iCastLevel = 3;
              break;
        case SPELL_BLESS:
              iSpellLevel = 1;
              sPotionTag = "NW_IT_MPOTION009";
              iCastLevel = 2;
              break;
        case SPELL_BULLS_STRENGTH:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION015";
              iCastLevel = 3;
              break;
        case SPELL_CATS_GRACE:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION014";
              iCastLevel = 3;
              break;
        case SPELL_CLARITY:
              iSpellLevel = 3;
              sPotionTag = "NW_IT_MPOTION007";
              iCastLevel = 3;
              break;
        case SPELL_CURE_CRITICAL_WOUNDS:
              iSpellLevel = 4;
              //sPotionTag = "NW_IT_MPOTION003";
              sPotionTag = "PotionOfCCW";
              iCastLevel = 7;
              break;
        case SPELL_CURE_LIGHT_WOUNDS:
              iSpellLevel = 1;
              //sPotionTag = "NW_IT_MPOTION001";
              sPotionTag = "PotionOfCLW";
              iCastLevel = 2;
              break;
        case SPELL_CURE_MODERATE_WOUNDS:
              iSpellLevel = 2;
              //sPotionTag = "NW_IT_MPOTION020";
              sPotionTag = "PotionOfCMW";
              iCastLevel = 3;
              break;
        case SPELL_CURE_SERIOUS_WOUNDS:
              iSpellLevel = 3;
              //sPotionTag = "NW_IT_MPOTION002";
              sPotionTag = "PotionOfCSW";
              iCastLevel = 5;
              break;
        case SPELL_EAGLE_SPLEDOR:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION010";
              iCastLevel = 3;
              break;
        case SPELL_ENDURANCE:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION013";
              iCastLevel = 3;
              break;
        case SPELL_FOXS_CUNNING:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION017";
              iCastLevel = 3;
              break;
        case SPELL_HEAL:
              iSpellLevel = 6;
              sPotionTag = "NW_IT_MPOTION012";
              iCastLevel = 11;
              break;
        case SPELL_INVISIBILITY:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION008";
              iCastLevel = 3;
              break;
        case SPELL_LESSER_RESTORATION:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION011";
              iCastLevel = 3;
              break;
        case SPELL_IDENTIFY:
              iSpellLevel = 1;
              sPotionTag = "NW_IT_MPOTION019";
              iCastLevel = 3;
              break;
        case SPELL_OWLS_WISDOM:
              iSpellLevel = 2;
              sPotionTag = "NW_IT_MPOTION018";
              iCastLevel = 3;
              break;
        case SPELL_HASTE:
              iSpellLevel = 3;
              sPotionTag = "NW_IT_MPOTION004";
              iCastLevel = 5;
              break;
        default:
              sPotionTag = "NOTSUPPORTED";
              break;

   }
   if (sPotionTag != "NOTSUPPORTED")
   {
        iCost = iSpellLevel*iCastLevel*50;
        nXPCost = iCost/25;
        nTime = iCost/1000*POTIONWAITTIME;
        if (nXP >= nXPCost && (nXP-nXPCost) >= nMinXP)
        {
            if (GetGold(oPlayer) >= iCost/2)
            {
                //Take Gold
                //Take XP
                TakeGoldFromCreature(iCost, oPlayer, TRUE);
                SetXP(oPlayer, nXP-nXPCost);

                //Remove Bottle from Chest
                DestroyObject(oBottle);
                if (POTIONWAITTIME)
                {
                    //Delay Creation of Potion -- set global flags
                    SetLocalInt(oMod, "PotionCreated"+sPCName+sCDK, 1);
                    SetLocalInt(oMod, "nPotionCreatedHour"+sPCName+sCDK, GetTimeHour());
                    SetLocalInt(oMod, "nPotionCreatedDay"+sPCName+sCDK, GetCalendarDay());
                    SetLocalInt(oMod, "nPotionCreatedMonth"+sPCName+sCDK, GetCalendarMonth());
                    SetLocalInt(oMod, "nPotionCreatedYear"+sPCName+sCDK, GetCalendarYear());
                    SetLocalInt(oMod, "nPotionCreationTime"+sPCName+sCDK, nTime);
                    SetLocalString(oMod, "sCreatedPotion"+sPCName+sCDK, sPotionTag);
                    iSuccess = 1;
                }
                else
                    CreateItemOnObject(sPotionTag, oPlayer);
            }
            else
                //Not enough gold
                SendMessageToPC(oPlayer, "Not enough gold. You need " + IntToString(iCost/2) + "gp to create this potion.");
                iSuccess = 2;
        }
        else
            //Not enough xp
            SendMessageToPC(oPlayer, "Not enough XP. You need " + IntToString(nMinXP + nXPCost) + "xp to create this potion.");
            iSuccess = 3;

   }
}

