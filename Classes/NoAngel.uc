class NoAngel extends NoMutatorBase;

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;

	goat = GGGoat( other );
	if( goat != none )
	{
		if( IsValidForPlayer( goat ) )
		{
			GGPlayerControllerGame( goat.Controller ).mTimeNeededForAngel = 1000000.f;
		}
	}
	super.ModifyPlayer( other );
}

DefaultProperties
{}