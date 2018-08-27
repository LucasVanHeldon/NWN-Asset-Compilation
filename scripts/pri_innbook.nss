//::///////////////////////////////////////////////
//:: Stop Removal of Purple Rose Inn Book
//:: pri_innbook
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

This script makes it impossible to remove the Purple
Rose Inn Book from any object that runs this script.

The main purpose of this script is to keep that book
in one place so that all my view it.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 8, 2002
//:://////////////////////////////////////////////

void main()
{
object oBookShelf = OBJECT_SELF;
object oBook = GetInventoryDisturbItem();
string sBook = GetTag(oBook);
if (sBook == "ThePurpleRoseInn")
 {
  DestroyObject(oBook);
  CreateItemOnObject("thepurpleroseinn", oBookShelf, 1);
 }
}
