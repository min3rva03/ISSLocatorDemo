# International Space Station Current Location

Este proyecto muestra la ubicación del ISS(International Space Station) en un mapa mediante el consumo de una API de localización y Google Maps.

Implementa Google Maps [Google Maps SDK for iOS](https://developers.google.com/maps/documentation/ios-sdk/) y
una API para devolver la ubicación actual de la estación espacial [ISS location] (http://open-notify.org/Open-Notify-API/ISS-Location-Now/)
                
# Comienzo

Para agregar manualmente Maps SDK al proyecto y configurar los ajustes de compilación.
consultar (https://developers.google.com/maps/documentation/ios-sdk/config#install-manually)

Para obtener APIKEY
consultar(https://developers.google.com/maps/documentation/ios-sdk/config#get-key)

# Estructura del proyecto

El proyecto se organiza de la siguiente manera:

**Helpers** contiene la clase *Bindable* encargada de escuchar el cambio de valores en el Modelo y pasarla al controller.

**ServiceManager** Es la clase mediante la cuál se realiza el consumo del API.

En su método *sendRequest* recibe la URL a la que se consultara. Implementa ademas el protocolo *ServiceManagerDelegate* al que una vez realizada la consulta llama a su método *serviceResponse*  y le proporciona el ResponseData de la consulta, este a su vez llama al mètodo *setUsrDefaults* del ViewModel que se encarga de almacenar esta respuesta en **user defaults**(Se tomo la determinación de almacenarse en user defaults ya que no es información sensible que requiera sea encriptada o que requiera  otro tipo de seguridad).)
Esta clase tambien contiene una función llamada *sendRequestWithClosure* que no es mas que otra forma de realizar la consulta al API de ubicación,  se dejo comentada en el codigo como referencia de que puede realizarse lo mismo con delegados o closures.

**ISSLocatorModule** Contiene la implementación de la arquitectura **MVVM**

-    **Model** 
                *IssLocatorModel* Contiene el modelo de datos con los campos que devuelve el API como lo son: latitud, longitud, mensaje, marcador de tiempo , etc. Y que conforme se actualicen nos permitirá ir conociendo la ubicacion de la ISS.
                
-    **View**
- *IssLocatorController* Mediante la implementación de GoogleMaps nos permitirá conocer la posición de la ISS en el mapa.
                        para hacer uso del mapa esta clase declara una constante llamada camera que recibe tres valores : latitud , longitud y zoom  que permite conocer la posición en el mapa y una constante mapView que es la vista sobre la cuál se muestra el mapa.
                        Implementa un timer que cada 10 segundos solicita al ViewModel se consulte la ubicación, esto mediante
                        
- *self.issLocatorVM.requestLocation()*
                        Tambien se implementa un marcador que permite conocer la ubicación de la ISS de manerá visual.
                        Adicional a esto cabe mencionar que al final de la clase se observa el método *rightBarButtonTapped* que realiza la navegación entre una pantalla (la del mapa) y la pantalla del listado de ubicaciones (botón derecho del TabBar).
                        
- *IssLocatorTableController* Esta clase muestra el registro de las ultimas ubicaciones. Implementa los métodos del delegado *UITableViewDelegate*  y *UITableViewDataSource* para obtener el numero de secciones y celdas que va a mostrar  , asi como la información que mostrará en cada una.
                  Para obtener el numero de registros consulta al IssLocatorViewModel en su método *getnumberOfRows()* que internamente consulta el método *getUsrDefaults()* para conocer el número de registros almacenados en User Defaults.
                  Para conocer y mostrar la información de las ultimas ubicaciones se consulta nuevamente el ViewModel en su método getCellForRow que consulta los registros de user Defaults y permite mostrar la latitud y longitud de las ubicaciones.
-    **ViewModel**
                *IssLocatorViewModel* Es el intermediario entre la vista y el modelo.
                Contiene la implementación de los métodos :
                    <func requestLocation()> Hace uso del sendRequest del serviceManager proporcionando la URL(http://api.open-notify.org/iss-now.json) del Api a la que se realizará la consulta
                    <func getInitialData()>     Proporciona a un array el registro de userDefaults obteniendolo del *getUsrDefaults*
                    <func serviceResponse()>    Añade a un array la respuesta del servicio
                    <func parseJSONLocator()>   Realiza el parseo de datos de la respuesta del servicio al modelo de datos del Model
                    <func setUsrDefaults>       Almacena en user defaults los valores obtenidos del servicio
                    <func removeUsrDefaults()>  Elimina todos los registros de userDefaults
                    <func getUsrDefaults()>     Permite obtener los registros almacenados en user defaults
                    <func getnumberOfRows()>    Permite conocer el número de registros almacenados en el user defaults
                    <func getCellForRow()>      Permite obtener un registro de userDefaults en una posicion especifica
                
# Ejecución del proyecto

Clonar repositorio y compilar.
Las dependencias para este proyecto se integraron de forma manual por lo cuál no requiere configuraciones adicionales.
