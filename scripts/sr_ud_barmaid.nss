//barmaid v1.1 - ericksoa, based on work by Rhodan.
//if you enhance this, and its useful, please post new version to nwn.bioware.com.  Thanx.
//also, it would be nice if you give credit to contributing authors as well :)
//some behaviour consts
//drinking age switches
int NOMINORS_USE_DRINKING_AGE = FALSE;
int NOMINORS_DRINKING_AGE_HUMAN = 21;
int NOMINORS_DRINKING_AGE_ELF = 100;
int NOMINORS_DRINKING_AGE_HALFELF = 50;
int NOMINORS_DRINKING_AGE_GNOME = 50;
int NOMINORS_DRINKING_AGE_HALFLING = 50;
int NOMINORS_DRINKING_AGE_DWARF = 50;
int NOMINORS_DRINKING_AGE_HALFORC = 21;
string NOMINORS_GREETING = "Ah, what a cutie.  You know you are not old enough to drink the hard stuff now.";
//race service switches
int SERVE_HUMAN = TRUE;
int SERVE_ELF = TRUE;
int SERVE_HALFELF = TRUE;
int SERVE_GNOME = TRUE;
int SERVE_HALFLING = TRUE;
int SERVE_DWARF = TRUE;
int SERVE_HALFORC = TRUE;
string NO_SERVICE_RACE = "Sorry, this tavern does not serve your race.  Begone!";
//reputation based service
int SERVE_ALL_REPUTATIONS = FALSE;
int REPUTATION_THRESHOLD = 30;
string NO_SERVICE_REPUTATION = "Your reputation is well known. (-Disdainful sniff-) You are not welcome here.";
//sexual attraction switches
int WILL_FLIRT = TRUE; //determines whether barmaid/master will flirt w/customers
int ISA_HOMO = FALSE; //needs no explanation
int FLIRT_THRESHOLD1 = 15; //mild level flirting
int FLIRT_THRESHOLD2 = 28; //"wanna meet later tonight" - "meet me upstairs later" - "here's a key"
string FLIRT_HELLO1_1 = "Hello cutie :)   What can I do you for?";
string FLIRT_HELLO1_2 = "Nice to have you today.  Can I get you anything ::wink::?";
string FLIRT_HELLO1_3 = "It is my pleasure to serve you!  What would you like (besides me)?";
string FLIRT_HELLO2_1 = "Oh my god.  I have to say you are the best looking customer I have seen in these parts.  Your wish is my command.  ::whisper:: Meet me upstairs later... lets have some fun";
string FLIRT_HELLO2_2 = "I have a thing for people who look like you.  Lets meet tonight.  Can I get you a drink?";
string FLIRT_HELLO2_3 = ":::whisper::: for a good time, see me in my room tonight.  Can I get you anything?";
//repulsion switches
int WILL_BE_REPULSED = TRUE;
int REPULSION_THRESHOLD1 = 7; //ugh, can I get you a beer?
int REPULSION_THRESHOLD2 = 4; // ::barmaid throws up at the sight of you::
string REPULSED_1 = "Ugh, can I get you a drink?";
string REPULSED_2 = "Jeez, who hit you with the ugly wand.  I can see why you drink!  Let me help.";
//normal dialog
string GREETING_1 = "Is there anything I can get for you?";
string GREETING_2 = "How can I be of service?";
//available items
string ITEM1 = "Local Ale";
string ITEM1_DESCRIPTION = "We have the local favorite, Mosstone Ale";
string ITEM1_TAG = "<custom item tag to be delivered>";
string ITEM2 = "Tethyrian Rum";
string ITEM2_DESCRIPTION = "If you can stand it, we also have Tethyrian Rum";
string ITEM2_TAG = "<custom item tag to be delivered>";
string ITEM3 = "Amnian Gin";
string ITEM3_DESCRIPTION = "And finally, we recommend the Amnian Gin if you are headed out adventuring";
string ITEM1_MINOR = "Milk";
string ITEM1_MINOR_DESCRIPTION = "For such a young adventurer, a nice glass of Milk";
string ITEM1_MINOR_TAG = "<custom item tag to be delivered>";
//function declarations
void main();
//object BarmaidAquireTarget(object oBarmaid, float fDistance=10.0);
//object BarmaidGetBar(object oBarmaid);
//object BarmaidGetStation(object oBarmaid);
string GetBarmaidsOrderQuery(object oBarmaid, object oTarget);
string GetBarmaidsOrderQuery(object oBarmaid, object oTarget)
{
    //based on faction/alignment/charisma/whatever, do different
    //  responses here.

    int iRace = GetRacialType(oTarget);
    int iRaceBarmaid = GetRacialType(oTarget);
    int iGender = GetGender(oTarget);
    int iBarmaidGender = GetGender(oBarmaid);
    int iRep = GetReputation(oBarmaid, oTarget);
    int iCharisma = GetAbilityScore(oTarget, ABILITY_CHARISMA);
    int iAge = GetAge(oTarget);
    int iGenderWorks = FALSE;
    if ((iGender == iBarmaidGender) && ISA_HOMO) iGenderWorks = TRUE;
    if ((iGender != iBarmaidGender) && (ISA_HOMO == FALSE)) iGenderWorks = TRUE;
    if ((SERVE_ALL_REPUTATIONS==FALSE) && (iRep < REPUTATION_THRESHOLD))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_REPUTATION);
    }
    if ((iRace == RACIAL_TYPE_HUMAN) && (SERVE_HUMAN == FALSE))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_RACE + "We don't serve humans.");
    }
    if ((iRace == RACIAL_TYPE_ELF) && (SERVE_ELF == FALSE))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_RACE + "We don't serve elves.");
    }
    if ((iRace == RACIAL_TYPE_HALFELF) && (SERVE_HALFELF == FALSE))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_RACE + "We don't serve half-elves.");
    }
    if ((iRace == RACIAL_TYPE_GNOME) && (SERVE_GNOME == FALSE))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_RACE + "We don't serve gnomes.");
    }
    if ((iRace == RACIAL_TYPE_HALFLING) && (SERVE_HALFLING == FALSE))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_RACE + "We don't serve halflings.");
    }
    if ((iRace == RACIAL_TYPE_DWARF) && (SERVE_DWARF == FALSE))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_RACE + "We don't serve dwarves.");
    }
    if ((iRace == RACIAL_TYPE_HALFORC) && (SERVE_HALFORC == FALSE))
    {
        SetLocalInt(oBarmaid, "REFUSE_CURRENT_CUSTOMER", TRUE);
        return(NO_SERVICE_RACE + "We don't serve halforcs.");
    }
    if(NOMINORS_USE_DRINKING_AGE)
    {
        if ((iRace == RACIAL_TYPE_HUMAN) && (iAge < NOMINORS_DRINKING_AGE_HUMAN))
        {
            SetLocalInt(oBarmaid, "KIDMENU_CURRENT_CUSTOMER", TRUE);
            return(NOMINORS_GREETING);
        }
        if ((iRace == RACIAL_TYPE_ELF) && (iAge < NOMINORS_DRINKING_AGE_ELF))
        {
            SetLocalInt(oBarmaid, "KIDMENU_CURRENT_CUSTOMER", TRUE);
            return(NOMINORS_GREETING);
        }
        if ((iRace == RACIAL_TYPE_HALFELF) && (iAge < NOMINORS_DRINKING_AGE_HALFELF))
        {
            SetLocalInt(oBarmaid, "KIDMENU_CURRENT_CUSTOMER", TRUE);
            return(NOMINORS_GREETING);
        }
        if ((iRace == RACIAL_TYPE_GNOME) && (iAge < NOMINORS_DRINKING_AGE_GNOME))
        {
            SetLocalInt(oBarmaid, "KIDMENU_CURRENT_CUSTOMER", TRUE);
            return(NOMINORS_GREETING);
        }
        if ((iRace == RACIAL_TYPE_HALFLING) && (iAge < NOMINORS_DRINKING_AGE_HALFLING))
        {
            SetLocalInt(oBarmaid, "KIDMENU_CURRENT_CUSTOMER", TRUE);
            return(NOMINORS_GREETING);
        }
        if ((iRace == RACIAL_TYPE_DWARF) && (iAge < NOMINORS_DRINKING_AGE_DWARF))
        {
            SetLocalInt(oBarmaid, "KIDMENU_CURRENT_CUSTOMER", TRUE);
            return(NOMINORS_GREETING);
        }
        if ((iRace == RACIAL_TYPE_HALFORC) && (iAge < NOMINORS_DRINKING_AGE_HALFORC))
        {
            SetLocalInt(oBarmaid, "KIDMENU_CURRENT_CUSTOMER", TRUE);
            return(NOMINORS_GREETING);
        }
    }
    if (WILL_FLIRT && (iCharisma >= FLIRT_THRESHOLD1) && (iRace == iRaceBarmaid) && iGenderWorks)
    {
        if (WILL_FLIRT && (iCharisma >= FLIRT_THRESHOLD2) && (iRace == iRaceBarmaid) && iGenderWorks)
        {
            int iRespNum = Random(2);
            switch(iRespNum)
            {
                case 0:
                    return(FLIRT_HELLO2_1);
                    break;
                case 1:
                    return(FLIRT_HELLO2_2);
                    break;
                case 2:
                    return(FLIRT_HELLO2_3);
                    break;
            }
        }
        else
        {
            //ok, perhaps we are repulsed
            if (WILL_BE_REPULSED && (iCharisma <= REPULSION_THRESHOLD2))
            {
                 return(REPULSED_2);
            }
            else
            {
                if (WILL_BE_REPULSED && (iCharisma <= REPULSION_THRESHOLD1))
                {
                    return(REPULSED_1);
                }
            }
        }
    }
    int iGreet = Random(1);
    switch(iGreet)
    {
        case 0:
            return(GREETING_1);
        case 1:
            return(GREETING_2);
    }
    return(GREETING_1);
}

void main()
{
    // You need these outside the nEvent switch
    // So you can use the varnames in other signal events
    string sMe = GetTag(OBJECT_SELF);
    int STATUS_READY =10;
    int STATUS_BUSY=20; // do nothing-she's busy with actions
    int STATUS_FINISHED=30;
    int STAGE_AQUIRE =10; //case doesn't use vars
    int STAGE_GETORDER =20; //but put these here to
    int STAGE_WALKBAR =30; //remind you which values
    int STAGE_GETDRINK =40; //mean what
    int STAGE_DELIVERDRINK =50;
    int STAGE_GOSTATION =60;
    float BARMAID_DISTANCE_THRESHOLD=1000.0; //set this to the range you want the barmaid to work
    int IS_BARMAID_EFFICIENT = TRUE;
    object oTarget;
    object oBarWP;
    object oStaWP;
    int nEvent=GetUserDefinedEventNumber();
    switch (nEvent)
    {
        case 2005:
            //set state ready
            //SendMessageToPC(GetFirstPC(), "BARMAID - Status is ready");
            SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY);
            break;
        case 2006:
            //set state busy
            //SendMessageToPC(GetFirstPC(), "BARMAID - Status is busy");
            SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_BUSY);
            break;
        case 2007:
            //set state finished
            //SendMessageToPC(GetFirstPC(), "BARMAID - Status is done");
            SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_FINISHED);
            break;
        case 1001: // heartbeats
            int nStatus=GetLocalInt(OBJECT_SELF,"MAID_STATUS");
            int nStage=GetLocalInt(OBJECT_SELF,"MAID_STAGE");
            int iAquired = FALSE; //default, perhaps there is nobody to aquire
            if (nStatus==0) // Just started new module
            {
                nStatus=STATUS_READY;
                SetLocalInt(OBJECT_SELF,"MAID_STAGE",nStatus);
                nStage=STAGE_AQUIRE;
                SetLocalInt(OBJECT_SELF,"MAID_STAGE",nStage);
            }
            switch(nStage)
            {
                case 10: // STAGE_AQUIRE
                    if (nStatus==STATUS_READY)
                    {
                        SetLocalInt(OBJECT_SELF, "REFUSE_CURRENT_CUSTOMER", FALSE);
                        SetLocalInt(OBJECT_SELF, "KIDMENU_CURRENT_CUSTOMER", FALSE);
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_BUSY);
                        int iNth = GetLocalInt(OBJECT_SELF, "NTH_PATRON");
                        iNth++;
                        object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, iNth);
                        //SpeakString("I am looking for the " + IntToString(iNth) + " potential customer");
                        if (GetStringLeft(GetTag(oTarget), 7) == "BARMAID")
                        {
                            //SpeakString("arrgh, cant serve to miself");
                            //do not take orders from other barmaids
                            iNth++;
                            oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, iNth);
                        }
                        if (GetStringLeft(GetTag(oTarget), 9) == "BARTENDER")
                        {
                            //SpeakString("arrgh, cant serve to miself");
                            //do not take orders from other barmaids
                            iNth++;
                            oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, iNth);
                        }
                        if (GetIsObjectValid(oTarget) && (GetDistanceToObject(oTarget) <= BARMAID_DISTANCE_THRESHOLD))
                        {
                            //SpeakString("Ahh, found a customer, the " + IntToString(iNth) + "th one");
                            iAquired = TRUE;
                            SetLocalObject(OBJECT_SELF,"MAID_TARGET",oTarget);
                            SetLocalInt(OBJECT_SELF, "NTH_PATRON", iNth);
                            ActionForceMoveToObject(oTarget, IS_BARMAID_EFFICIENT);
                            ActionDoCommand(SetFacingPoint(GetPositionFromLocation(GetLocation(oTarget))));
                            AssignCommand(oTarget, ActionWait(5.0));
                            AssignCommand(oTarget, SetFacingPoint(GetPositionFromLocation(GetLocation(GetObjectByTag(sMe)))));
                        }
                        else
                        {
                            //try setting iNth back to 1, cycling
                            //SpeakString("Starting from the beginning");
                            iNth = 1;
                            oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, iNth);
                            if (GetIsObjectValid(oTarget) && (GetDistanceToObject(oTarget) <= BARMAID_DISTANCE_THRESHOLD))
                            {
                                //special case, we have cycled through all patrons
                                iAquired = TRUE;
                                SetLocalObject(OBJECT_SELF,"MAID_TARGET",oTarget);
                                SetLocalInt(OBJECT_SELF, "NTH_PATRON", iNth);
                                ActionForceMoveToObject(oTarget, IS_BARMAID_EFFICIENT);
                                ActionDoCommand(SetFacingPoint(GetPositionFromLocation(GetLocation(oTarget))));
                                AssignCommand(oTarget, ActionWait(5.0));
                                AssignCommand(oTarget, SetFacingPoint(GetPositionFromLocation(GetLocation(GetObjectByTag(sMe)))));
                            }
                            else
                            {
                                //Ok, so there is nobody here :)
                                //SpeakString("Beer here...  beer here...");
                                SetLocalInt(OBJECT_SELF, "NTH_PATRON", 0);
                            }
                        }
                        if (iAquired)
                            // we can move to finished and start serving someone only if there is
                            // someone to serve
                            ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_FINISHED));
                        else
                            //otherwise, reset to ready and try again in 6 seconds
                            ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY));
                    }
                    if (nStatus==STATUS_FINISHED)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY);
                        SetLocalInt(OBJECT_SELF,"MAID_STAGE",STAGE_GETORDER);
                    }
                    break;
                case 20: // STAGE_GETORDER
                    if (nStatus==STATUS_READY)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_BUSY);
                        object oTarget = GetLocalObject(OBJECT_SELF, "MAID_TARGET");
                        //do your animations etc
                        ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 2.0);
                        ActionDoCommand(SpeakString(GetBarmaidsOrderQuery(OBJECT_SELF, oTarget)));
                        //mention the items as appropriate
                        if (GetLocalInt(OBJECT_SELF,"REFUSE_CURRENT_CUSTOMER"))
                        {
                            //set it up as if we already delivered the drink
                            ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY));
                            ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STAGE",STAGE_DELIVERDRINK));
                        }
                        else
                        {
                            //do more stuff
                            //mention the items as appropriate
                            if (GetLocalInt(OBJECT_SELF,"KIDMENU_CURRENT_CUSTOMER"))
                            {
                                ActionDoCommand(SpeakString(ITEM1_MINOR_DESCRIPTION));
                            }
                            else
                            {
                                ActionWait(3.0);
                                ActionDoCommand(SpeakString(ITEM1_DESCRIPTION));
                                ActionWait(3.0);
                                ActionDoCommand(SpeakString(ITEM2_DESCRIPTION));
                                ActionWait(3.0);
                                ActionDoCommand(SpeakString(ITEM3_DESCRIPTION));
                                ActionWait(3.0);
                                int iDrink = Random(2);
                                AssignCommand(oTarget, ActionWait(8.0));
                                switch(iDrink)
                                {
                                    case 0:
                                        AssignCommand(oTarget, DelayCommand(8.0, SpeakString("I'll have " + ITEM1)));
                                        break;
                                    case 1:
                                        AssignCommand(oTarget, DelayCommand(8.0, SpeakString("A " + ITEM2 + " sounds good!")));
                                        break;
                                    case 2:
                                        AssignCommand(oTarget, DelayCommand(8.0, SpeakString("Please bring me a " + ITEM3)));
                                        break;
                                }
                                SetLocalInt(OBJECT_SELF, "DRINK_CHOSEN", iDrink);
                                ActionWait(3.0);
                                ActionDoCommand(SpeakString("Coming right up!"));
                            }
                            ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_FINISHED));
                        }
                    }
                    if (nStatus==STATUS_FINISHED)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY);
                        SetLocalInt(OBJECT_SELF,"MAID_STAGE",STAGE_WALKBAR);
                    }
                    break;
                case 30: // STATE WALKBAR
                    if (nStatus==STATUS_READY)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_BUSY);
                        //Get a Waypoint for going to the bar, or if "object invalid", say that there is no bar, and that
                        //  perhaps the owner of the place should buy one
                        //if you make your bar waypoint in the manner of WP_<your waitresstag>_BAR you are in good shape
                        object oBarWP = GetObjectByTag("WP_" + GetTag(OBJECT_SELF) + "_BAR");
                        if (GetIsObjectValid(oBarWP)==FALSE)
                        {
                            ActionDoCommand(SpeakString("Perhaps the owner should buy a bar for this inn... and tag it WP_" + GetTag(OBJECT_SELF) + "_BAR"));
                        }
                        else
                        {
                            ActionForceMoveToObject(oBarWP, IS_BARMAID_EFFICIENT);
                            ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_FINISHED));
                        }
                    }
                    if (nStatus==STATUS_FINISHED)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY);
                        SetLocalInt(OBJECT_SELF,"MAID_STAGE",STAGE_GETDRINK);
                    }
                    break;
                case 40: //STAGE_GETDRINK
                    if (nStatus==STATUS_READY)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_BUSY);
                        object oTarget = GetLocalObject(OBJECT_SELF, "MAID_TARGET");
                        //do your animations etc
                        //at some point, this should do something like say "give me a <what they ordered>"
                        int iDrinkChosen = GetLocalInt(OBJECT_SELF, "DRINK_CHOSEN");
                        switch(iDrinkChosen)
                        {
                            case 0:
                                ActionDoCommand(SpeakString("Please give me a " + ITEM1));
                                break;
                            case 1:
                                ActionDoCommand(SpeakString("I need a " + ITEM2));
                                break;
                            case 2:
                                ActionDoCommand(SpeakString("Load me up with a " + ITEM3));
                                break;
                        }
                        ActionWait(2.0);
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0);
                        ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_FINISHED));
                    }
                    if (nStatus==STATUS_FINISHED)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY);
                        SetLocalInt(OBJECT_SELF,"MAID_STAGE",STAGE_DELIVERDRINK);
                    }
                    break;
                case 50: //STAGE_DELIVER_DRINK
                    if (nStatus==STATUS_READY)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_BUSY);
                        object oTarget = GetLocalObject(OBJECT_SELF, "MAID_TARGET");
                        ActionForceMoveToObject(oTarget);
                        // update to actually base the selection on what was selected...
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0);
                        int iDrinkChosen = GetLocalInt(OBJECT_SELF, "DRINK_CHOSEN");
                        switch(iDrinkChosen)
                        {
                            case 0:
                                ActionDoCommand(SpeakString("Here's your " + ITEM1));
                                break;
                            case 1:
                                ActionDoCommand(SpeakString("Enjoy your " + ITEM2));
                                break;
                            case 2:
                                ActionDoCommand(SpeakString("Your " + ITEM3 + " is ready!"));
                                break;
                        }
                        int iTargetSits = GetLocalInt(oTarget, "SITS_DOWN");
                        if (iTargetSits)
                        {
                            object oMychair = GetNearestObjectByTag("chair", oTarget);
                            AssignCommand(oTarget, DelayCommand(4.0, ActionSit(oMychair)));
                        }
                        ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_FINISHED));
                    }
                    if (nStatus==STATUS_FINISHED)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY);
                        SetLocalInt(OBJECT_SELF,"MAID_STAGE",STAGE_GOSTATION);
                    }
                    break;
                case 60: //STAGE_GO_STATION
                    if (nStatus==STATUS_READY)
                    {
                        //Get a Waypoint for going to the station, or if "object invalid", say that there is no station, and that
                        //  perhaps the owner of the place should set one
                        //if you make your station waypoint in the manner of WP_<your waitresstag>_STA you are in good shape
                        object oStaWP = GetObjectByTag("WP_" + GetTag(OBJECT_SELF) + "_STA");
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_BUSY);
                        if (GetIsObjectValid(oStaWP)==FALSE)
                        {
                            ActionDoCommand(SpeakString("Perhaps the owner should give me a station in this inn... and tag it WP_" + GetTag(OBJECT_SELF) + "_STA"));
                        }
                        else
                        {
                            ActionForceMoveToObject(oStaWP);
                            ActionDoCommand(SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_FINISHED));
                        }
                    }
                    if (nStatus==STATUS_FINISHED)
                    {
                        SetLocalInt(OBJECT_SELF,"MAID_STATUS",STATUS_READY);
                        SetLocalInt(OBJECT_SELF,"MAID_STAGE",STAGE_AQUIRE);
                    }
                    break;
        }
        break;
   }
}

