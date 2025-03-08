class NoChat extends NoMutatorBase;

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
	super.Tick( deltaTime );

	if(GGGameInfoMMO(WorldInfo.Game) != none)
	{
		RemoveChat();
	}
}

function RemoveChat()
{
	local int i;

	for(i=0 ; i<mGoats.Length ; i=i)
	{
		if(RemoveChatForGoat(mGoats[i]))
		{
			mGoats.Remove(i, 1);
		}
		else
		{
			i++;
		}
	}
}

function bool RemoveChatForGoat(GGGoat goat)
{
	if(GGPlayerControllerGame(goat.Controller) != none && GGHUDMMO(GGPlayerControllerGame(goat.Controller).myHUD) != none)
	{
		GGHUDMMO(GGPlayerControllerGame(goat.Controller).myHUD).mOnlyShowActorOverlay=true;
		return true;
	}
	return false;
}

DefaultProperties
{}