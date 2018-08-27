void main()
{
    SetLocalLocation(GetArea(OBJECT_SELF),"MyLocation",GetLocation(OBJECT_SELF));
    DestroyObject(OBJECT_SELF);
    DestroyObject(GetObjectByTag("CloakedFigure2"));
    DestroyObject(GetObjectByTag("CloakedFigure3"));
    DestroyObject(GetObjectByTag("CloakedFigure4"));
    SignalEvent(GetArea(OBJECT_SELF), EventUserDefined(1010));
}
