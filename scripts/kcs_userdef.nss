string PreString(string sString, string sSubStr)
{
    string sResult;

    if (!((sSubStr=="") || (sString=="")))
    {
      int iPos = FindSubString(sString,sSubStr);

      if (iPos >= 0)
      {
        sResult = GetSubString(sString,0,iPos);
      }
      else
      {
        sResult = sString;
      }
      return sResult;
    }
    else
    {
      return sString;
    }
}

string PostString(string sString, string sSubStr)
{

    string sResult;

    if (!((sSubStr=="") || (sString=="")))
    {
      int iPos = FindSubString(sString, sSubStr);
      int iLen = GetStringLength(sString);
      int iSubLen = GetStringLength(sSubStr);

      if (iPos >= 0)
      {
        sResult = GetSubString(sString, iPos+iSubLen, iLen-(iPos+iSubLen));
      }
      else
      {
        sResult = "";
      }
      return sResult;
    }
    else
    {
      return sString;
    }
}

string ReplaceString(string sString, string sToReplace, string sNewSubStr)
{
    if (sToReplace == "") return sString;

    string sResult = sString;

    // As long as an instance of our replace-string exists, keep walking
    // the string and altering it.
    while ((FindSubString(sResult, sToReplace)) >= 0)
    {
      sResult = PreString(sResult, sToReplace) + sNewSubStr + PostString(sResult, sToReplace);
    }

    return sResult;
}


void main()
{
  // User Defined Event for NPCs using the Keyword Conversation System
  //
  // Version    : 1.0
  // Date       : Aug 29, 2002
  // Written by : Kurt Jaegers (NWN User Name : Krebbs)
  //

  // OnDialogue Event:

  //ActionSpeakString("UserDefinedEvent");

  if (GetUserDefinedEventNumber() == 1004)
  {
    // Make sure we are supposed to be listening
    if (GetIsListening(OBJECT_SELF))
    {
      // Ensure it is a PC that is speaking this text
      object oPC = GetLastSpeaker();
      if (GetIsPC(oPC))
      {
        // Ensure that the speaker is within five feet
        if (GetDistanceToObject(oPC) <= 5.0f)
        {
          // Get the listen pattern number
          int iPattern = GetListenPatternNumber();
          string sPattern = IntToString(iPattern);
          int iPreAnim = GetLocalInt(OBJECT_SELF, "KCS_PREA" + sPattern);
          int iPostAnim = GetLocalInt(OBJECT_SELF, "KCS_POSTA" + sPattern);
          string sResponse = GetLocalString(OBJECT_SELF, "KCS_RESP" + sPattern);
          string sMoveTo = GetLocalString(OBJECT_SELF, "KCS_MOVETO" + sPattern);
          string sScript = GetLocalString(OBJECT_SELF, "KCS_SCRIPT" + sPattern);
          string sMisc = GetLocalString(OBJECT_SELF, "KCS_SMISC" + sPattern);
          int iMisc = GetLocalInt(OBJECT_SELF, "KCS_IMISC" + sPattern);

          // Turn to face the speaker
          SetFacingPoint(GetPosition(oPC));

          // Play the Pre Animation if one was specified.
          if (iPreAnim)
          {
            ActionPlayAnimation(iPreAnim);
          }

          // Speak the response if one was specified.
          if (!(sResponse==""))
          {
            sResponse = ReplaceString(sResponse, "&N", PreString(GetName(oPC)," "));
            sResponse = ReplaceString(sResponse, "&F", GetName(oPC));
            ActionSpeakString(sResponse);
          }

          // Move to waypoint if one was specified
          if (!(sMoveTo==""))
          {
            ActionMoveToLocation(GetLocation(GetWaypointByTag(sMoveTo)));
          }

          // Execute a script if one was specified.
          if (!(sScript==""))
          {
            SetLocalObject(OBJECT_SELF, "KCS_PCSPEAKER", oPC);
            if (!(iMisc==0))
            {
              SetLocalInt(OBJECT_SELF, "KCS_IMISC", iMisc);
            }
            if (!(sMisc==""))
            {
              SetLocalString(OBJECT_SELF, "KCS_SMISC", sMisc);
            }
            SetLocalInt(OBJECT_SELF, "KCS_LASTPATTERN", iPattern);
            AssignCommand(OBJECT_SELF, ExecuteScript(sScript, OBJECT_SELF));
            AssignCommand(OBJECT_SELF, DeleteLocalObject(OBJECT_SELF, "KCS_SPEAKER"));
            if (!(iMisc==0))
            {
              AssignCommand(OBJECT_SELF, DeleteLocalInt(OBJECT_SELF, "KCS_IMISC"));
            }
            if (!(sMisc==""))
            {
              AssignCommand(OBJECT_SELF, DeleteLocalString(OBJECT_SELF, "KCS_SMISC"));
            }
          }

          // Play Post Text/Script animation if one was specified
          if (iPostAnim)
          {
            ActionPlayAnimation(iPostAnim);
          }
        }
      }
    }
  }
}
