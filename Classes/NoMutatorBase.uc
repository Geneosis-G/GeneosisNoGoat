class NoMutatorBase extends GGMutator
	implements( NoInterface )
	config(Geneosis);

var config bool isNoMutatorHidden;

/**
 * if the mutator should be selectable in the Custom Game Menu.
 */
static function bool IsUnlocked( optional out array<AchievementDetails> out_CachedAchievements )
{
	return !default.isNoMutatorHidden;
}

static function bool IsVisible()
{
	return !default.isNoMutatorHidden;
}

static function SetVisible(bool visible)
{
	if(default.isNoMutatorHidden == !visible)
		return;

	default.isNoMutatorHidden=!visible;
	StaticSaveConfig();
}

static function string GetName()
{
	local string className;

	className=string(default.class);
	ReplaceText(className, "No", "No ");

	return className;
}

DefaultProperties
{

}