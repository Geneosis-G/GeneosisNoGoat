class NoManual extends NoMutatorBase;

var array<GGGoat> mGoats;

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;

	goat = GGGoat( other );
	if( goat != none )
	{
		if( IsValidForPlayer( goat ) )
		{
			mGoats.AddItem(goat);
		}
	}
	super.ModifyPlayer( other );
}

event Tick( float deltaTime )
{
	local GGGoat goat;

	super.Tick( deltaTime );

	//WorldInfo.Game.Broadcast(self, "Manual.mGoats.Length=" $ mGoats.Length);
	foreach mGoats(goat)
	{
		//WorldInfo.Game.Broadcast(self, goat @ goat.Controller @ GGPlayerControllerGame( goat.Controller ) @ GGPlayerControllerGame( goat.Controller ).mIsDoingManual);
		if( GGPlayerControllerGame( goat.Controller ).mIsDoingManual )
		{
			//WorldInfo.Game.Broadcast(self, goat $ " doing manual");
			GGPlayerControllerGame( goat.Controller ).StopManual( false );
		}
	}
}

DefaultProperties
{}