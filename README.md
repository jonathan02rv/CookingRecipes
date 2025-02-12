# CookingRecipes

## Descripción

Este proyecto es una aplicación iOS desarrollada en Swift, que sigue las mejores prácticas de arquitectura y diseño para garantizar escalabilidad y mantenimiento eficiente. En este documento se detallan las decisiones clave tomadas en el desarrollo, incluyendo patrones de diseño, librerías externas y otras consideraciones técnicas.

## Patrones de Diseño

Para estructurar el código de manera modular y flexible, se ha utilizado el patrón de diseño MVVM-R (Model-View-ViewModel-Router). Este patrón permite desacoplar la lógica de negocio de la interfaz de usuario, asi como la lógica de navegación entre vistas, facilitando la implementación de pruebas unitarias. Además de ello el desarrollo del proyecto está base en Clean Architecture de tal manera que podamos seguir los principios SOLID.

El proyecto está implementado en tres capas creadas dentro de un WorkSpace, cada capa tiene su propio modelo de datos:

Presentation Layer - CookingRecipes (iOS project):
--------------------------------------------------

Cada escena contiene las siguientes clases:

* Model: Representa los datos que usa la View de la escena.

* Controller: Funciona como intermediario entre el ViewModel y la View de la escena, esta clase responde a los eventos del usuario en la UI, manda a ejecutar acciones en el ViewModel y le comunica a la View los cambios de estado del Modelo a travez del framework Combine (para este proyecto ejemplo).

* View: Representa la UI de la escena que interactúa con el usuario.

* ViewModel: Contiene la lógica de presentación, esta clase se comunica con los UseCases (lógica de negocio) y bindea los datos necesarios al controlador de la Vista.


Domain Layer - Domain (Framework project):
------------------------------------------

* BusinessModel: Representa el modelo de datos que necesitan los casos de uso.

* UseCase: Contiene la lógica de negocio. Esta clase se comunica con los repositories para obtener la data que necesita el caso de uso. Esta clase tiene un delegado que decide ejecutar acciones de acuerdo a la respuesta del repositorio


Data Layer - DataRecipes (Framework proyect):
---------------------------------------------

* Entity: Representa el modelo de datos que gestiona el DataSosurce a traves de un ApiRequest. Estos conforman el protocolo Decodable.

* Repository: Funciona como intermediario entre el DataSource y el UseCase. Esta clase desconoce la implementación del DataSource. Esta clase realiza peticiones al DataSource y reenvia la respuesta al UseCase con el modelo transformado tipo de modelo que el UseCase reconozca.

* DataSource: Implementa las llamadas a los servicios que el repositorio necesita. Para este proyecto se usa URLSession, pero se puede usar cualquier framework para hacer las peticiones a los servicion. Esto no afecta al repository ya que desconoce la implementacion.

## Otras Consideraciones Técnicas

* Toda la implementación está basada en inversion de dependencias para poder desacoplar el codigo y poder mockear la implementacion, esto ayuda a la implementacion de unit test y a la escalabilidad del proyecto.
* Se usó combine para la comunicación entre el viewModel y el controlador de la vista
* Se creó en un workSpace que contiene las 3 capas del proyecto (Presentation Layer, Domain Layer, Data Layer)
* Se implementaron unit test para el UseCase del RecipesList y el ViewModel del RecipesList de las capas Presentation y Domain respectivamente.
* Para correr las unit test de cada capa, seleccionar el target requerido (CookingRecipes ó Domain).

## Diagrama de la Arquitectura:

![MVVM-R](https://github.com/user-attachments/assets/c7e9213e-9d1b-44fc-8d67-e69c439383ff)


## Instalación y Configuración

* Clonar el repositorio:
git clone https://github.com/jonathan02rv/CookingRecipes.git

* Abrir el proyecto en Xcode y ejecutar en un simulador o dispositivo real.

## Contacto

* Para cualquier consulta o contribución, puedes contactar a [jonathan02rv@gmail.com].
* Link GitHub: https://github.com/jonathan02rv
