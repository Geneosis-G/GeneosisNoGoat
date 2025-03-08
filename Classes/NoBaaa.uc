class NoBaaa extends NoMutatorBase;

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;

	goat = GGGoat( other );
	if( goat != none )
	{
		if( IsValidForPlayer( goat ) )
		{
			goat.mBaaSoundCue=none;
		}
	}
	super.ModifyPlayer( other );
}

DefaultProperties
{}