void main()
{
    location lSwimWP = GetLocation(GetObjectByTag("Landing_WP2"));

    AssignCommand(GetPCSpeaker(), ActionJumpToLocation(lSwimWP));
}
