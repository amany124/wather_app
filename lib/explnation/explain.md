# text field
 
  TextField(
          *onChanged*: (value) {
            // take every letter you enter in the text field
          },
           *onSubmitted*: (value) {
            // take te whole value after you submit in the text field
          },
            *decoration*: **InputDecoration**(
              **label**: Text('Search'),
              **hintText**: 'search a city',
              **suffixIcon**: Icon(Icons.search),
    // *the default border*
              **border**: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
    // *the enabled border means when the text field is enable to click and write on it*
   // some times the text field is unenabled to write in it
              **enabledBorder**: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.green),
              ),
            
  // *foucused border means that you already clicked the text field*         
            **focusedBorder**: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red),
           
   // *if you want to change the hight of the text field you make padding arround the content of the text field*
 **contentPadding**:
                  EdgeInsets.symmetric(vertical: 32, horizontal: 22),
           
           
              ),
            ),
          ),

===================================================

// so instead of using the normal costructor after we make the request from the api to convert the data that comes from the request to object

// we can use the named the constructor 
//you will just give him the data that comes from the request and auomatically the constructor will return object using these data to use it in the ui .

 # like this:
          json parameter is //**the data from requesting the api**
*factory* WeatherModel.fromjson(  json  ) 
  {
    **return** *WeatherModel*(
      cityName: json['location']['name'],
      date: json['location']['localtime'],
      image: json['forecast']['forecastday'][0]['day']['condition']['icon'],
      temp: json['forecast']['forecastday'][0]['day']['avgtemp_c'],
      maxtemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      mintemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      weatherCondition: json['forecast']['forecastday'][0]['day']['condition']
          ['text'],
    );
  }

===================================================

 // *state management (cubit)*
when you want to display the data and the place that you will trigger the method and get the data which is [search_view] is diffrent than the place that you will use this data which is the [home_view] then you have to use state management like bloc (cubit) to make this 
// we have to provide the same data for both the [search_view] and the [home_view]

  **we have constant steps to provide the cubit**

   1_ create state
   2_create cubit
   3_create function
   4_provide cubit to the widget that contains both the widgets we want to provide the cubit for
   5_integrate the cubit (the part of the states in the ui)
   6_ trigger cubit(the part of the logic in the ui)

=========================================================
 
 *changing the theme color*

 // in material app there is attribute called theme 
 // you can control the theme and make it light or dark or custom theme from you 
 // in this application we will make our palete of colors to make the theme of the application 
 // as the weather condition we can change the theme color

   Widget build(BuildContext context) {
    return BlocProvider(
      // the function of bloc provide is just to create
      // object from the weathercubit and provide this object
      //  for both widgets we will need to use this object at them
      create: (context) => getWeatherCubit(),
      child:  *MaterialApp*(
        theme: ThemeData(
          // brightness: Brightness.dark or Brightness.light,
    // **primary swatch it takes material color with is a palate of colors containg shades**
          
  **primarySwatch**: Colors.amber,
       
        ),
        home: HomeView(),
      ),
    );
  }

  [amber] is material color which is map key an value

  static const MaterialColor amber = MaterialColor(
    _amberPrimaryValue,
    <int, Color>{
       50: Color(0xFFFFF8E1),
      100: Color(0xFFFFECB3),
      200: Color(0xFFFFE082),
      300: Color(0xFFFFD54F),
      400: Color(0xFFFFCA28),
      *500: Color(_amberPrimaryValue)*,
      600: Color(0xFFFFB300),
      700: Color(0xFFFFA000),
      800: Color(0xFFFF8F00),
      900: Color(0xFFFF6F00),
    },
  );

  // it is normal to give material color to color  it will just take the primarycolor from the palete which is 500 but you can not give color to material color

  =====================================================

  in material app widget when you try to acess the value of weather condition using cubit you will have exception 

  # Exception has occurred.
ProviderNotFoundException (Error: Could not find the correct Provider<getWeatherCubit> above this WeatherApp Widget

This happens because you used a `BuildContext` that does not include the provider

// this happens because you use context before the context of cubit creation you have to use context after cubit creation
 
 // **this is context before creation of cubit**
 Widget build(BuildContext [context]) {
    return BlocProvider(
      // the function of bloc provide is just to create
      // object from the weathercubit and provide this object
      //  for both widgets we will need to use this object at them
      *create: (context) => getWeatherCubit()*,
      child:  MaterialApp(
        theme: ThemeData(
          // brightness: Brightness.dark or Brightness.light,
          primarySwatch:  getThemeColor(BlocProvider.of<getWeatherCubit>(**context**).weather_data.  
   # we use the context here and it will make exception
          weatherCondition),
        ),
        home: HomeView(),
      ),
    );
  }
  //to solve this exception we have to make new context after creation of cubit 
  // **builder widget** can help to provide new context and solve this problem

  like here :
     
   Widget build(BuildContext **context**) {
    return BlocProvider(
      create: (context) => getWeatherCubit(),
      child: *Builder*(builder: (*context*) {
   // we will have here new context and then we can use it
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: getThemeColor(
                BlocProvider.of<getWeatherCubit>(*context*)
                    .weather_data
                    .weatherCondition),
          ),
          home: HomeView(),
        );
      }),
    );
  }