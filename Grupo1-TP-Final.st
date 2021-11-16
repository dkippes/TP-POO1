!classDefinition: #SistemaDeArchivosTest category: 'Grupo1-TP-Final'!
TestCase subclass: #SistemaDeArchivosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!SistemaDeArchivosTest methodsFor: 'sistemaDeArchivos_testing' stamp: 'TC 11/15/2021 23:54:54'!
test001_cuandoUnaCarpetaEsCreada_EstaTieneUnNombre_UnaListaDeArchivos_UnaListaDeCarpetas_UnaFechaDeCreacionYUnaFechaDeModificacion

	"Setup"
	| unaCarpetaNueva  unaFechaDeCreacion |
	
	unaCarpetaNueva _ Folder conNombre: 'root'.
	unaFechaDeCreacion _ FixedGregorianDate today.

	Assert that: unaCarpetaNueva nombre isEqualTo: 'root'.
	Assert isFalse: (unaCarpetaNueva tieneCarpetas).
	Assert isFalse: (unaCarpetaNueva tieneArchivos). 
	Assert that: unaCarpetaNueva fechaDeCreacion isEqualTo: unaFechaDeCreacion.
	Assert that: unaCarpetaNueva fechaDeModificacion isEqualTo: unaFechaDeCreacion.! !

!SistemaDeArchivosTest methodsFor: 'sistemaDeArchivos_testing' stamp: 'TC 11/15/2021 23:52:21'!
test002_cuandoUnArchivoSeCrea_EsteTieneNombre_UnaFechaDeCreacionYUnaFechaDeModificacion
	"Setup"
	| unArchivoNuevo unaFechaDeCreacion |
	
	unArchivoNuevo _ File conNombre: 'Archivo1.txt'.
	unaFechaDeCreacion _ FixedGregorianDate today.
	
	Assert that: unArchivoNuevo nombre isEqualTo: 'Archivo1.txt'.
	Assert that: unArchivoNuevo fechaDeCreacion isEqualTo: unaFechaDeCreacion.
	Assert that: unArchivoNuevo fechaDeModificacion isEqualTo: unaFechaDeCreacion.! !


!classDefinition: #TerminalTest category: 'Grupo1-TP-Final'!
TestCase subclass: #TerminalTest
	instanceVariableNames: 'unUserRootDefault unUserRootDiego1234 unUserRootDiego4321'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 21:01:26'!
errorContraseñaOUsuarioIncorrecto

	^ 'El nombre y/o contraseña es incorrecta'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 21:01:19'!
errorUsuarioNoExistente

	^ 'El usuario no existe'! !

!TerminalTest methodsFor: 'factory-methods' stamp: 'dk 11/14/2021 20:45:57'!
unaTerminalConUnUsuarioRootDefaultLogueado

	| unaTerminal |
	unaTerminal _ Terminal iniciarSesion: unUserRootDefault .
	^ unaTerminal .! !


!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 20:59:26'!
test001_cuandoUnaTerminalSeCrea_iniciaSesionUnUsuarioRoot

	"Setup"
	| terminal unUsuarioRoot |
	unUsuarioRoot _ RootUser conNombre: 'root' yContraseña: 'root' .
	terminal _ Terminal iniciarSesion: unUsuarioRoot .
	
	Assert isTrue: (terminal tieneAlUsuarioLogueado: unUsuarioRoot) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 20:57:54'!
test002_cuandoUnaTerminalSeCrea_iniciaSesionUnUsuario

	"Setup"
	| unUsuarioLogueado unaTerminal |
	unUsuarioLogueado _ PublicUser conNombre: 'Diego' yContraseña: '1234' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioLogueado en: unaTerminal .
	unaTerminal iniciarSesion: unUsuarioLogueado .
	
	Assert isTrue: (unaTerminal tieneAlUsuarioLogueado: unUsuarioLogueado) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:02:45'!
test003_cuandoUnaTerminalSeCrea_unUsuarioTrataDeLoguearseInsactifactoriamente

	"Setup & Exercise"
	| unUserInexistente |
	unUserInexistente _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserInexistente]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:02:37'!
test004_cuandoUnaTerminalSeCrea_unUsuarioRootTrataDeLoguearseInsactifactoriamente

	"Setup"
	| unUserRootInexistente |
	unUserRootInexistente _ RootUser conNombre: 'Diego' yContraseña: '4321' .
	
	Assert
        should: [ Terminal iniciarSesion: unUserRootInexistente ]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:04:12'!
test005_cuandoUnaTerminalSeCrea_unUsuarioRoot_agregaUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isTrue: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .
	Assert isTrue: unaTerminal tieneUnUsuarioLogueado .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:04:53'!
test006_cuandoUnaTerminalSeCrea_unUsuarioRoot_borraUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	unUserRootDefault borrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert isFalse: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .
	Assert isTrue: unaTerminal tieneUnUsuarioLogueado .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:07:40'!
test007_cuandoUnaTerminalSeCrea_unUsuarioRoot_trataDeAgregarUnUsuarioYaExistente

	"Setup"
	| unaTerminal unUsuarioAAgregar |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	
	Assert
        should: [ unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .  ]
        signal: Error
        withDescription: self errorContraseñaOUsuarioIncorrecto .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:07:47'!
test008_cuandoUnaTerminalSeCrea_unUsuarioRoot_trataDeBorraUnUsuarioInexistente

	"Setup"
	| terminal unUsuarioAAgregar |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	terminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	Assert
        should: [ unUserRootDefault borrarUsuario: unUsuarioAAgregar en: terminal  ]
        signal: Error
        withDescription: self errorUsuarioNoExistente .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:11:26'!
test009_cuandoUnaTerminalSeCrea_unUsuarioRoot_modificaUnUsuario

	"Setup"
	| unaTerminal unUsuarioAAgregar unUsuarioModificado |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unUsuarioModificado _ PublicUser conNombre: 'Tomas' yContraseña: '9876' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	"Exercise"
	unUserRootDefault registrarUsuario: unUsuarioAAgregar en: unaTerminal .
	unUserRootDefault modificarUsuario: unUsuarioAAgregar por: unUsuarioModificado en: unaTerminal .
	
	Assert isFalse: (unaTerminal tieneAlUsuario: unUsuarioAAgregar) .
	Assert isTrue: unaTerminal tieneUnUsuarioLogueado .
! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 21:11:16'!
test010_cuandoUnaTerminalSeCrea_unUsuarioRoot_modificaUnUsuarioInexistente

	"Setup"
	| unaTerminal unUsuarioAAgregar unUsuarioModificado |
	unUsuarioAAgregar _ PublicUser conNombre: 'Diego' yContraseña: '4321' .
	unUsuarioModificado _ PublicUser conNombre: 'Tomaz' yContraseña: '9876' .
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
	
	Assert
        should: [ unUserRootDefault modificarUsuario: unUsuarioAAgregar por: unUsuarioModificado en: unaTerminal  ]
        signal: Error
        withDescription: self errorUsuarioNoExistente .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/14/2021 22:02:41'!
test011_cuandoUnUsuarioIniciaSesion_EsteTieneUnaCarpetaRoot
	"Setup"
	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado .
		

	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/14/2021 22:24:20'!
test012_cuandoUnUsuarioEscribeMkDirEnLaTerminal_CreaUnaCarpetaEnElDirectorio
	"Setup"
	| unaTerminal unaCarpeta |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpeta _ Folder	 conNombre: 'Tomas'.

	"Exersice" 
	unaTerminal mkdir: unaCarpeta.

	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert isTrue: (unaTerminal tieneCarpetasEnElDirectorioActual).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 23:08:50'!
test013_cuandoUnUsuarioEscribeMkDirEnLaTerminal_CreaUnaCarpetaEnElDirectorio_EstaYaExiste

	| unaTerminal unaCarpetaNueva |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaNueva _ Folder	 conNombre: 'Tomas'.

	"Exersice" 
	unaTerminal mkdir: unaCarpetaNueva .
	unaTerminal cd: unaCarpetaNueva .

	"Assert"
	Assert isFalse: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert that: (unaTerminal carpetaActual) isEqualTo: unaCarpetaNueva .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 23:06:49'!
test014_cuandoUnUsuarioEscribeMkDirEnLaTerminal_CreaUnaCarpetaEnElDirectorio_EstaNoYaExiste

	| unaTerminal unaCarpeta |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpeta _ Folder	 conNombre: 'Tomas'.

	"Assert"
	Assert
        should: [unaTerminal cd: unaCarpeta .]
        signal: Error
        withDescription: 'La carpeta no existe en este directorio' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 23:12:35'!
test015_cuandoUnUsuarioEscribeCDParaVolverEnLaTerminal_esteVuelveUnaCarpetaHaciaAtras

	| unaTerminal unaCarpetaNueva otraCarpetaNueva |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaNueva _ Folder	 conNombre: 'Tomas'.
	otraCarpetaNueva _ Folder	 conNombre: 'Diego'.

	"Exersice" 
	unaTerminal mkdir: unaCarpetaNueva .
	unaTerminal cd: unaCarpetaNueva .
	unaTerminal mkdir: otraCarpetaNueva .
	unaTerminal cd: otraCarpetaNueva .
	unaTerminal cd .

	"Assert"
	Assert isFalse: (unaTerminal estaParadaEnElDirectorioRaiz).
	Assert that: (unaTerminal carpetaActual) isEqualTo: unaCarpetaNueva .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/14/2021 23:16:18'!
test016_cuandoUnUsuarioEscribeCDParaVolverEnLaTerminal_estandoEnLaCarpetaRoot_esteNoPuedeRegresarALaCarpetaAnterior

	| unaTerminal |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.

	"Assert"
	Assert
        should: [unaTerminal cd .]
        signal: Error
        withDescription: 'No se puede volver, estas parado en root' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/15/2021 23:05:02'!
test017_cuandoUnUsuarioIngresaAVariasCarpetas_esteLuegoRegresaARoot

	| unaTerminal otraCarpetaDiego unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ Folder	 conNombre: 'Tomas'.
	otraCarpetaDiego _ Folder	 conNombre: 'Diego'.

	"Exersice"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
	unaTerminal mkdir: otraCarpetaDiego .
	unaTerminal cd: otraCarpetaDiego .
	unaTerminal cd .
	unaTerminal cd .
	
	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/15/2021 23:05:52'!
test018_cuandoUnUsuarioIngresaAVariasCarpetas_esteLuegoRegresaPasandoseDeRoot_noPuedeRetrocederMasAllaDeLaCarpetaRoot

	| unaTerminal otraCarpetaDiego unaCarpetaTomas |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpetaTomas _ Folder	 conNombre: 'Tomas'.
	otraCarpetaDiego _ Folder	 conNombre: 'Diego'.

	"Exersice"
	unaTerminal mkdir: unaCarpetaTomas .
	unaTerminal cd: unaCarpetaTomas .
	unaTerminal mkdir: otraCarpetaDiego .
	unaTerminal cd: otraCarpetaDiego .
	unaTerminal cd . 
	unaTerminal cd .
	
	"Assert"
	Assert
        should: [unaTerminal cd .]
        signal: Error
        withDescription: 'No se puede volver, estas parado en root' .
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/15/2021 23:57:40'!
test019_cuandoUnUsuarioCreaUnArchivo_EsteLoCreaEnElDirectorioRaiz_ConElComandoTouch

	| unaTerminal unArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoNuevo _ File conNombre: 'Archivo1.txt'.
	
	"Exercise"
	unaTerminal touch: unArchivoNuevo.
	
	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .
	Assert isTrue: (unaTerminal tieneElArchivoEnElDirectorioActual: unArchivoNuevo).! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/16/2021 00:02:58'!
test020_cuandoUnUsuarioCreaUnArchivo_EsteYaExisteEnElDirectorioActual

	| unaTerminal unArchivoNuevo |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoNuevo _ File conNombre: 'Archivo1.txt'.
	
	"Exercise"
	unaTerminal touch: unArchivoNuevo.
	
	"Assert"
	Assert isTrue: (unaTerminal estaParadaEnElDirectorioRaiz) .
	Assert
        should: [unaTerminal touch: unArchivoNuevo.]
        signal: Error
        withDescription: 'No se puede crear un archivo con el mismo nombre' .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/16/2021 00:17:04'!
test021_cuandoUnUsuarioListaElContenidoDelDirectorio_ConElComandols_EsteMuestraTodosLosArchivosYLasCarpetas

	| unaTerminal unArchivoNuevo unaCarpetaNueva listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unArchivoNuevo _ File conNombre: 'Archivo1.txt'.
	unaCarpetaNueva _ Folder conNombre: 'Diego'.
	listaDeArchivosYCarpetas _ Set new.
	listaDeArchivosYCarpetas add: unArchivoNuevo.
	listaDeArchivosYCarpetas add: unaCarpetaNueva.
	
	"Exercise"
	unaTerminal touch: unArchivoNuevo.
	unaTerminal mkdir: unaCarpetaNueva.
	
	"Assert"
	Assert that: unaTerminal ls isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/16/2021 00:25:03'!
test022_cuandoUnUsuarioListaElContenidoDelDirectorio_ConElComandols_EsteNoTieneNadaEnElDirectorioActual

	| unaTerminal listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	listaDeArchivosYCarpetas _ Set new.

	"Assert"
	Assert that: unaTerminal ls isEqualTo: listaDeArchivosYCarpetas.! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/16/2021 00:37:52'!
test023_cuandoUnUsuarioBorraUnArchivo_EsteDesapareceDelDirectorioActual

	| unaTerminal unaArchivoNuevo listaDeArchivosYCarpetas |
	"Setup"
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaArchivoNuevo _ File conNombre: 'Archivo1.txt'.
	listaDeArchivosYCarpetas _ Set new.
	
	"Exercise"
	unaTerminal touch: unaArchivoNuevo.
	unaTerminal rm: unaArchivoNuevo.

	"Assert"
	Assert that: unaTerminal ls isEqualTo: listaDeArchivosYCarpetas.! !


!TerminalTest methodsFor: 'setUp/tearDown' stamp: 'dk 11/14/2021 21:09:11'!
setUp

	unUserRootDefault _ RootUser conNombre: 'root' yContraseña: 'root' .
	unUserRootDiego1234 _ RootUser conNombre: 'Diego' yContraseña: '1234' .
	unUserRootDiego4321 _ RootUser conNombre: 'Diego' yContraseña: '4321' .! !


!classDefinition: #File category: 'Grupo1-TP-Final'!
Object subclass: #File
	instanceVariableNames: 'nombre fechaDeCreacion fechaDeModificacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!File methodsFor: 'initialization' stamp: 'TC 11/15/2021 23:47:12'!
initialize

	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.! !

!File methodsFor: 'initialization' stamp: 'TC 11/15/2021 23:41:17'!
initializeConNombre: unNombre 
	nombre := unNombre.! !


!File methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:52:39'!
fechaDeCreacion
	^fechaDeCreacion! !

!File methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:52:49'!
fechaDeModificacion
	^fechaDeModificacion! !

!File methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:41:30'!
nombre
	^nombre! !


!File methodsFor: 'testing' stamp: 'TC 11/16/2021 00:11:19'!
nombreEsIgual: nombreArchivo
	^ (nombre = nombreArchivo) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'File class' category: 'Grupo1-TP-Final'!
File class
	instanceVariableNames: ''!

!File class methodsFor: 'instance creation' stamp: 'TC 11/15/2021 23:40:45'!
conNombre: unNombre
	
	^self new initializeConNombre: unNombre. ! !


!classDefinition: #Folder category: 'Grupo1-TP-Final'!
Object subclass: #Folder
	instanceVariableNames: 'nombreCarpeta listaDeCarpetas listaDeArchivos fechaDeCreacion fechaDeModificacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Folder methodsFor: 'initialization' stamp: 'dk 11/15/2021 23:17:25'!
inicializarConNombre: unNombre
	nombreCarpeta _ unNombre.! !

!Folder methodsFor: 'initialization' stamp: 'TC 11/15/2021 23:49:58'!
initialize

	listaDeCarpetas _ Set new.
	listaDeArchivos _ Set new. 
	fechaDeCreacion _ FixedGregorianDate today.
	fechaDeModificacion _ FixedGregorianDate today.! !


!Folder methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:55:08'!
fechaDeCreacion
	^fechaDeCreacion! !

!Folder methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:55:22'!
fechaDeModificacion
	^fechaDeModificacion! !

!Folder methodsFor: 'accessing' stamp: 'TC 11/15/2021 23:59:18'!
listaDeArchivos
	^listaDeArchivos! !

!Folder methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:17:47'!
listaDeCarpetas
	^ listaDeCarpetas! !

!Folder methodsFor: 'accessing' stamp: 'TC 11/14/2021 21:52:04'!
nombre
	^ nombreCarpeta.! !


!Folder methodsFor: 'testing' stamp: 'dk 11/15/2021 23:17:52'!
nombreEsIgual: unNombre
	^ nombreCarpeta = unNombre.! !

!Folder methodsFor: 'testing' stamp: 'TC 11/14/2021 21:58:34'!
tieneArchivos
	^ listaDeArchivos notEmpty.! !

!Folder methodsFor: 'testing' stamp: 'TC 11/14/2021 21:58:10'!
tieneCarpetas
	^ listaDeCarpetas notEmpty.! !


!Folder methodsFor: 'public actions' stamp: 'TC 11/14/2021 22:21:13'!
agregarCarpeta: unaCarpeta 
	listaDeCarpetas add: unaCarpeta.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Folder class' category: 'Grupo1-TP-Final'!
Folder class
	instanceVariableNames: ''!

!Folder class methodsFor: 'instance creation' stamp: 'TC 11/14/2021 21:50:48'!
conNombre: unNombre
	^self new inicializarConNombre: unNombre.! !


!classDefinition: #Terminal category: 'Grupo1-TP-Final'!
Object subclass: #Terminal
	instanceVariableNames: 'listaDeUsuarios usuarioLogueado carpetaActual carpetaAnterior listaDeDirectoriosVistos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'initialization' stamp: 'dk 11/15/2021 22:55:18'!
initialize

	| defaultUserRoot |
	defaultUserRoot _ RootUser conNombre: 'root' yContraseña: 'root'.
	listaDeUsuarios _ Set new .
	listaDeUsuarios add: defaultUserRoot .	
	carpetaActual _ Folder conNombre: 'root' .
	
	listaDeDirectoriosVistos _ OrderedCollection new .
	listaDeDirectoriosVistos add: carpetaActual .! !

!Terminal methodsFor: 'initialization' stamp: 'dk 11/14/2021 20:26:56'!
initializeIniciarSesion: unUser 

	self iniciarSesion: unUser .
	
	! !


!Terminal methodsFor: 'testing' stamp: 'dk 11/15/2021 23:17:15'!
esDirectoRaiz

	^ listaDeDirectoriosVistos size = 1! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:57:33'!
estaElUsuarioLogueado: unUser 

	^ unUser esIgualElUserYContraseñaA: usuarioLogueado ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/15/2021 23:08:20'!
estaParadaEnElDirectorioRaiz

	^ self esDirectoRaiz .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:30:32'!
tieneAlUsuario: unUser 

	^ listaDeUsuarios includes: unUser .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:58:39'!
tieneAlUsuarioLogueado: unUsuario 
	^ (self tieneUnUsuarioLogueado) & (self estaElUsuarioLogueado: unUsuario) .! !

!Terminal methodsFor: 'testing' stamp: 'TC 11/14/2021 22:25:35'!
tieneCarpetasEnElDirectorioActual
	^ carpetaActual tieneCarpetas.! !

!Terminal methodsFor: 'testing' stamp: 'TC 11/16/2021 00:00:16'!
tieneElArchivoEnElDirectorioActual: unArchivo
	^ (carpetaActual listaDeArchivos) includes: unArchivo.! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:30:48'!
tieneUnUsuarioLogueado

	^ usuarioLogueado notNil ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:33:35'!
unUsuarioTieneElMismoNombreQue: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | (unUserEnLaLista nombreEsIgual: unUser nombre)]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:34:13'!
unUsuarioTieneElMismoNombreYContraseñaQue: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | unUserEnLaLista esIgualElUserYContraseñaA: unUser]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/15/2021 23:14:14'!
unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista

	^ unaCarpetaEnLaLista nombreEsIgual: (unaCarpeta nombre)! !


!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:10:21'!
agregarCarpeta: unaCarpeta

	^ carpetaActual agregarCarpeta: unaCarpeta! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/14/2021 23:55:27'!
borrarUsuario: unUser 

	listaDeUsuarios remove: unUser 
		ifAbsent: [self errorUsuarioNoExistente]! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:15:32'!
cd
	
	(self esDirectoRaiz ) 
		ifTrue: [
			self error: 'No se puede volver, estas parado en root'
		] ifFalse: [
			listaDeDirectoriosVistos removeLast .
			carpetaActual _ listaDeDirectoriosVistos last .	
		]
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:12:56'!
cd: unaCarpeta 
	
	| listaDeCarpetasEnElDirectorioActual carpetaSiguiente |
	listaDeCarpetasEnElDirectorioActual _ carpetaActual listaDeCarpetas.
	
	carpetaSiguiente _ listaDeCarpetasEnElDirectorioActual detect: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista] 
		ifNone: [self error: 'La carpeta no existe en este directorio'.] .


	listaDeDirectoriosVistos add: carpetaSiguiente .
	carpetaActual _ (listaDeDirectoriosVistos last) .! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/16/2021 00:10:17'!
errorArchivoExistente

	^ self error: 'No se puede crear un archivo con el mismo nombre'! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:08:43'!
ingresarUsuario: unUserAIngresar
	
	(self unUsuarioTieneElMismoNombreQue: unUserAIngresar) 
		ifTrue: [self errorContraseñaOUsuarioIncorrecto] 
		ifFalse: [listaDeUsuarios add: unUserAIngresar].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/14/2021 23:41:06'!
iniciarSesion: unUserALoguease 
	
	(self unUsuarioTieneElMismoNombreYContraseñaQue: unUserALoguease) 
		ifTrue: [usuarioLogueado _ unUserALoguease] 
		ifFalse: [self errorContraseñaOUsuarioIncorrecto].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:13:17'!
mkdir: unaCarpeta

	|listaDeCarpetasEnElDirectorioActual|
	listaDeCarpetasEnElDirectorioActual _ carpetaActual listaDeCarpetas.
	
	(listaDeCarpetasEnElDirectorioActual anySatisfy: [:unaCarpetaEnLaLista | self unaCarpetaNombreEsIgual: unaCarpeta a: unaCarpetaEnLaLista]) 
		ifTrue: [self errorLaCarpetaYaExiste] 
		ifFalse: [self agregarCarpeta: unaCarpeta].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/15/2021 23:10:56'!
modificarUsuario: unUserAModificar por: unUserConModificaciones 

	(self unUsuarioTieneElMismoNombreQue: unUserAModificar) 
		ifTrue: [
			self ingresarUsuario: unUserConModificaciones .
			self borrarUsuario: unUserAModificar .
		] ifFalse: [
			self errorUsuarioNoExistente
		].! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/16/2021 00:42:25'!
rm: unArchivoABorrar
	|archivoABorrar listaDeArchivos|
	listaDeArchivos _ carpetaActual listaDeArchivos.
	
	archivoABorrar _ listaDeArchivos detect:[: unArchivo| unArchivo nombreEsIgual: unArchivoABorrar nombre] 
	ifNone:[self error: 'El archivo a borrar no existe'].
	carpetaActual listaDeArchivos remove: archivoABorrar.
	! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/16/2021 00:10:24'!
touch: unArchivo
	|listaDeArchivosEnElDirectorioActual|
	listaDeArchivosEnElDirectorioActual _ carpetaActual listaDeArchivos.
	(listaDeArchivosEnElDirectorioActual anySatisfy: [:unArchivoEnLaLista| unArchivoEnLaLista nombreEsIgual: unArchivo nombre]) 
	ifTrue:[self errorArchivoExistente]
	ifFalse:[listaDeArchivosEnElDirectorioActual add: unArchivo.]
	
	! !


!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:13:48'!
carpetaActual
	
	^ carpetaActual! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:06:59'!
errorContraseñaOUsuarioIncorrecto

	^ self error: 'El nombre y/o contraseña es incorrecta'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:10:07'!
errorLaCarpetaYaExiste

	^ self error: 'La carpeta ya existe en este directorio'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/15/2021 23:15:42'!
errorUsuarioNoExistente

	^ self error: 'El usuario no existe'! !

!Terminal methodsFor: 'accessing' stamp: 'TC 11/16/2021 00:21:31'!
ls
	|listaDeArchivosYCarpetas|
	listaDeArchivosYCarpetas _ Set new.
	listaDeArchivosYCarpetas addAll: carpetaActual listaDeArchivos.
	listaDeArchivosYCarpetas addAll: carpetaActual listaDeCarpetas.
	^ listaDeArchivosYCarpetas.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Terminal class' category: 'Grupo1-TP-Final'!
Terminal class
	instanceVariableNames: ''!

!Terminal class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 23:32:13'!
iniciarSesion: unUser
	^self new initializeIniciarSesion: unUser ! !


!classDefinition: #User category: 'Grupo1-TP-Final'!
Object subclass: #User
	instanceVariableNames: 'nombre contraseña'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!User methodsFor: 'accessing' stamp: 'dk 11/14/2021 20:37:31'!
contraseña

	^ contraseña! !

!User methodsFor: 'accessing' stamp: 'dk 11/14/2021 20:37:35'!
nombre

	^ nombre! !


!User methodsFor: 'testing' stamp: 'dk 11/14/2021 20:37:40'!
contraseñaEsIgual: unaContraseña 

	^ contraseña = unaContraseña ! !

!User methodsFor: 'testing' stamp: 'dk 11/14/2021 20:37:43'!
esIgualElUserYContraseñaA: unUser 

	^ (self nombreEsIgual: unUser nombre) & (self contraseñaEsIgual: unUser contraseña)! !

!User methodsFor: 'testing' stamp: 'dk 11/14/2021 20:37:46'!
nombreEsIgual: unNombre 

	^ nombre = unNombre ! !


!classDefinition: #PublicUser category: 'Grupo1-TP-Final'!
User subclass: #PublicUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!PublicUser methodsFor: 'initialization' stamp: 'dk 11/12/2021 23:48:10'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre := unNombre.
	contraseña := unaContraseña.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublicUser class' category: 'Grupo1-TP-Final'!
PublicUser class
	instanceVariableNames: ''!

!PublicUser class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 23:48:18'!
conNombre: unNombre yContraseña: unaContraseña
	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !


!classDefinition: #RootUser category: 'Grupo1-TP-Final'!
User subclass: #RootUser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!RootUser methodsFor: 'initialization' stamp: 'dk 11/14/2021 20:37:55'!
initializeConNombre: unNombre yContraseña: unaContraseña 

	nombre := unNombre.
	contraseña := unaContraseña.! !


!RootUser methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:38:19'!
borrarUsuario: unUser en: unaTerminal

	unaTerminal borrarUsuario: unUser .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:38:06'!
modificarUsuario: unUsuario por: unUsuarioConModificaciones en: unaTerminal
 
	unaTerminal modificarUsuario: unUsuario por: unUsuarioConModificaciones .! !

!RootUser methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:38:10'!
registrarUsuario: unUser en: unaTerminal

	unaTerminal ingresarUsuario: unUser .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootUser class' category: 'Grupo1-TP-Final'!
RootUser class
	instanceVariableNames: ''!

!RootUser class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 00:45:03'!
conNombre: unNombre yContraseña: unaContraseña 
	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !
