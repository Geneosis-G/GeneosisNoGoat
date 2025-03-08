class NoZombie extends NoMutatorBase;

var array<GGGoat> mGoats;
var float totalTime;

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
	totalTime = totalTime + deltaTime;

	if(totalTime < 10.f)
	{
		FindZombieGoatComponent();
	}
}

function FindZombieGoatComponent()
{
	local GGGoatZeroComponents tmpGZC;
	local int i;

	for(i=0 ; i<mGoats.Length ; i=i)
	{
		tmpGZC=GGGoatZeroComponents(GGGameInfo( class'WorldInfo'.static.GetWorldInfo().Game ).FindMutatorComponent(class'GGGoatZeroComponents', mGoats[i].mCachedSlotNr));
		if(tmpGZC != none)
		{
			mGoats.Remove(i, 1);
			tmpGZC.DetachFromPlayer();
		}
		else
		{
			i++;
		}
	}
}

DefaultProperties
{}