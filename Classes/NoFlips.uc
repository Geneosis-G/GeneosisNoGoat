class NoFlips extends NoMutatorBase;

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

	foreach mGoats(goat)
	{
		if( GGPlayerControllerGame( goat.Controller ) != none )
		{
			GGPlayerControllerGame( goat.Controller ).mFreeLook=false;
		}
	}
}

DefaultProperties
{}