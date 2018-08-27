void main()
{
    CreateObject(OBJECT_TYPE_CREATURE, "ogrezombie",
            GetLocation(GetObjectByTag("ImpaledCorpse1")), TRUE);
    CreateObject(OBJECT_TYPE_CREATURE, "ogrezombie",
            GetLocation(GetObjectByTag("ImpaledCorpse2")), TRUE);
    DestroyObject(GetObjectByTag("ImpaledCorpse1"));
    DestroyObject(GetObjectByTag("ImpaledCorpse2"));
}
