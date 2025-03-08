class NoSFX extends NoMutatorBase;

function ModifyPlayer(Pawn Other)
{
	local GGGoat goat;
	local GGPlayerControllerBase goatPC;

	goat = GGGoat( other );
	if( goat != none )
	{
		if( IsValidForPlayer( goat ) )
		{
			goatPC=GGPlayerControllerBase( goat.Controller );
			goatPC.SetAudioGroupVolume( 'SFX', 0.f);
		}
	}
	super.ModifyPlayer( other );
}

DefaultProperties
{}