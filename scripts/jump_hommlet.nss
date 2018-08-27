#include "nw_i0_plot"
void main()
{

    TakeGold(50,GetPCSpeaker());
    AssignCommand(GetPCSpeaker(),JumpToObject(GetWaypointByTag("WP_WAGON_HOMMLET")));
}
