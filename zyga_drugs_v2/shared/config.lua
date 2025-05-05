--[[                                                                            
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            
zzzzzzzzzzzzzzzzzyyyyyyy           yyyyyyyggggggggg   ggggg aaaaaaaaaaaaa   
z:::::::::::::::z y:::::y         y:::::yg:::::::::ggg::::g a::::::::::::a  
z::::::::::::::z   y:::::y       y:::::yg:::::::::::::::::g aaaaaaaaa:::::a 
zzzzzzzz::::::z     y:::::y     y:::::yg::::::ggggg::::::gg          a::::a 
      z::::::z       y:::::y   y:::::y g:::::g     g:::::g    aaaaaaa:::::a 
     z::::::z         y:::::y y:::::y  g:::::g     g:::::g  aa::::::::::::a 
    z::::::z           y:::::y:::::y   g:::::g     g:::::g a::::aaaa::::::a 
   z::::::z             y:::::::::y    g::::::g    g:::::ga::::a    a:::::a 
  z::::::zzzzzzzz        y:::::::y     g:::::::ggggg:::::ga::::a    a:::::a 
 z::::::::::::::z         y:::::y       g::::::::::::::::ga:::::aaaa::::::a 
z:::::::::::::::z        y:::::y         gg::::::::::::::g a::::::::::aa:::a
zzzzzzzzzzzzzzzzz       y:::::y            gggggggg::::::g  aaaaaaaaaa  aaaa
                       y:::::y                     g:::::g                  
                      y:::::y          gggggg      g:::::g                  
                     y:::::y           g:::::gg   gg:::::g                  
                    y:::::y             g::::::ggg:::::::g                  
                   yyyyyyy               gg:::::::::::::g                   
                                           ggg::::::ggg                     
                                              gggggg                        
                                              
                                              
                                              
                                    https://github.com/szalonyzyga
                                    szalonyzyga          
                                              
                                              
                                              
                                              
                                              
                                              
                                              
                                              --]]



Config = {}

Config.Interaction = 'marker'    -- target, 3dtext, marker

Config.Blacklistedjobs = {
    'police',
    'ambulance',
    'offpolice',
    'offambulance'
}



Config.Textoptions = {
    font = 4,
    red = 255,
    green = 255,
    blue = 255,
    alpha = 255,
    outline = true
}

Config.Markeroptions = {
    disttoappear = 10.0,
    type = 6,
    r = 255,
    g = 255,
    b = 255,
    a = 255,
    scalex = 4.0,
    scaley = 1.5,
    scalez = 4.0,
}




Config.ProgbarResource = 'lunar_progbar'

Config.Drugs = {
    {

        coords = vec3(82.4061, -1615.7618, 29.5917),

        blip = false,

        blipcolor = 1,

        blipsprite = 1,

        blipscale = 1.5,

        bliptext = "Drugs",

        jobtocollect = {
            --'org1'
        },

        licensetocollect = {
            --'weed_license'
        },

        itemstoremove = {
            ['weed'] = 0     -- item name and item quantity required
        },

        prop = true,
        
        propmodel = 'bkr_prop_weed_table_01b',

        propvec = vec4(82.9539, -1616.1539, 28.5917, 50.3786),

        itemstoadd = {
            ['weed_pooch'] = 1
        },

        -- PROGBAR --

        text = "Collecting. . .",

        duration = 3000,

        animdict = 'anim@gangops@facility@servers@bodysearch@',   

        anim = 'player_search',

        -- TARGET --

        icon = 'fa-solid fa-pills', 

        targettext = 'Collect.', 

        size = vec3(2.0, 2.0, 2.0), 

        -- 3D TEXT --

        text2 = 'Press ~r~[E]~s~ to collect.',

        -- MARKER --

        markertext = 'Press ~INPUT_CONTEXT~ to collect.'
    }
}