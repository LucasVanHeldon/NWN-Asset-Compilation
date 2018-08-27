// Lever OnUsed script
// By:Axe Murderer
// Posted: Monday, 24 May 2004 08:17PM
//:://////////////////////////////////

void main()
{ if( GetIsObjectValid( GetLastUsedBy()))
  { // Animate the lever.
    int iAnimation = GetLocalInt( OBJECT_SELF, "LeverState");
    if( iAnimation == 0)
    { iAnimation = ANIMATION_PLACEABLE_ACTIVATE;
      SetLocalInt( OBJECT_SELF, "LeverState", 1);
    }
    else
    { iAnimation = ANIMATION_PLACEABLE_DEACTIVATE;
      DeleteLocalInt( OBJECT_SELF, "LeverState");
    }
    PlayAnimation( iAnimation);

    // Put Lever activation code here.
  }
}
