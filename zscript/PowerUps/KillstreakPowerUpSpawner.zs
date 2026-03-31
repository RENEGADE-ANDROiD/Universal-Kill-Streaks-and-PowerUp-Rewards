class KillStreakPowerUp : Inventory replaces MegaSphere
{
    Default
    {
        Inventory.PickupMessage "You got a Random Power Up!";
        Inventory.PickupSound "misc/p_pkup";
        +INVENTORY.ALWAYSPICKUP;
        // +INVENTORY.INTERHUBSTRIP;  // Deprecated, removed
        +INVENTORY.AUTOACTIVATE;
        // Inventory.Icon "ICNXD0";   // Icon missing – comment out or provide a valid sprite
    }
    
    override bool Use(bool pickup)
    {
        int choice = random(0, 10);
        Class<Inventory> powerup;
        string message;
        
        switch(choice)
        {
        case 0:
            if(!ksCoffee){
                powerup = "Health";      // Generic fallback
                message = "Health!";
            }
            else{
                powerup = "CoffeeTime";
                message = "\ckCOFFEE TIME! \n\cjDouble the Speed!";
            }
            break;
        case 1:
            if(!ksTimesphere){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "TFST";
                message = "ZA WARUDO! \nTOKI WO TOMARE!";
            }
            break;
        case 2:
            if(!ksFamiliar){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "FamiliarSummon";
                message = "\crFAMILIAR! \n\cjSummons a Friendly Familiar that Fights for You ";
            }
            break;
        case 3:
            if(!ksCoffee){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "CoffeeTime";
                message = "\ckCOFFEE TIME! \n\cjDouble the Speed!";
            }
            break;
        case 4:
            if(!ksGuardsphere){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "GuardsphereST";
                message = "\ccGUARD SPHERE! \n\cjGain 75% Damage Reduction";
            }
            break;
        case 5:
            if(!ksCrucifix){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "Crucifix";
                message = "You got a crucifix rosary! Make 'em repent!";
            }
            break;
        case 6:
            if(!ksRegensphere){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "RegenSphere";
                message = "\cgREGEN SPHERE! \n\cjInfinite Healing!";
            }
            break;
        case 7:
            if(!ksDeflectionsphere){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "DeflectionSphere";
                message = "\cyDEFLECTION SPHERE! \n\cjAutomatically Deals Damage to Anyone that Hits You";
            }
            break;
        case 8:
            if(!ksLifeShield){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "LifeshieldSphere";
                message = "\cdLIFESHIELD! \n\cjGrants immunity through armor consumption";
            }
            break;
        case 9:
            if(!ksElectricsphere){
                powerup = "Health";
                message = "Health!";
            }
            else{
                powerup = "ElectricAuraSphere";
                message = "\cvELECTRIC AURA! \n\cjSummons an Electric Field that Stuns Nearby Enemies in Area";
            }
            break;
        case 10:
            if(!ksLegendsphere){
                powerup = "Health";
                message = "Health!";
            }
            else {
                powerup = "LegendSphere";
                message = "\cfLEGEND SPHERE! \n\cjYou Can't Go Below 1 HP! Go Crazy!";
            }
            break;
        default:
            powerup = "Health";
            message = "Health!";
            break;
        }
        
        if (powerup && Owner)
        {
            Owner.GiveInventory(powerup, 1);
            Owner.A_Print(message, 140);
        }
        
        return true;
    }
    
    States
    {
    Spawn:
        MEGA A 6 Bright;
        MEGA B 6 Bright;
        Loop;
    }
}