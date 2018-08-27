void main()
{
    if (GetEncounterActive()) {
        if(GetFirstItemInInventory(GetObjectByTag("SpiderwoodCocoon")) == OBJECT_INVALID)
            CreateItemOnObject("nw_it_gem013", GetObjectByTag("SpiderwoodCocoon"), 3);
    }

}
