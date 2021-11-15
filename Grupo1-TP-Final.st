!classDefinition: #SistemaDeArchivosTest category: 'Grupo1-TP-Final'!
TestCase subclass: #SistemaDeArchivosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!SistemaDeArchivosTest methodsFor: 'sistemaDeArchivos_testing' stamp: 'TC 11/14/2021 21:56:40'!
test001_cuandoUnaCarpetaEsCreada_EstaTieneUnNombre_UnaListaDeArchivosYUnaListaDeCarpetas

	"Setup"
	| unaCarpetaNueva  |
	
	unaCarpetaNueva _ Folder conNombre: 'root'.

	Assert that: unaCarpetaNueva nombre isEqualTo: 'root'.
	Assert isFalse: (unaCarpetaNueva tieneCarpetas).
	Assert isFalse: (unaCarpetaNueva tieneArchivos)! !


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

!TerminalTest methodsFor: 'terminal_testing' stamp: 'TC 11/14/2021 22:30:52'!
test013_cuandoUnUsuarioEscribeMkDirEnLaTerminal_CreaUnaCarpetaEnElDirectorio_EstaYaExiste
	
	| unaTerminal unaCarpeta |
	unaTerminal _ self unaTerminalConUnUsuarioRootDefaultLogueado.
	unaCarpeta _ Folder	 conNombre: 'Tomas'.

	"Exersice" 
	unaTerminal mkdir: unaCarpeta.

	"Assert"
	Assert
        should: [unaTerminal mkdir: unaCarpeta]
        signal: Error
        withDescription: 'La carpeta ya existe en este directorio'.! !


!TerminalTest methodsFor: 'setUp/tearDown' stamp: 'dk 11/14/2021 21:09:11'!
setUp

	unUserRootDefault _ RootUser conNombre: 'root' yContraseña: 'root' .
	unUserRootDiego1234 _ RootUser conNombre: 'Diego' yContraseña: '1234' .
	unUserRootDiego4321 _ RootUser conNombre: 'Diego' yContraseña: '4321' .! !


!classDefinition: #Folder category: 'Grupo1-TP-Final'!
Object subclass: #Folder
	instanceVariableNames: 'nombreCarpeta listaDeCarpetas listaDeArchivos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Folder methodsFor: 'initialization' stamp: 'TC 11/14/2021 21:51:23'!
inicializarConNombre: unNombre
	nombreCarpeta:= unNombre.! !

!Folder methodsFor: 'initialization' stamp: 'TC 11/14/2021 21:57:33'!
initialize

	listaDeCarpetas:= Set new.
	listaDeArchivos:= Set new.! !


!Folder methodsFor: 'accessing' stamp: 'TC 11/14/2021 22:40:38'!
listaDeCarpetas
	^listaDeCarpetas! !

!Folder methodsFor: 'accessing' stamp: 'TC 11/14/2021 21:52:04'!
nombre
	^ nombreCarpeta.! !


!Folder methodsFor: 'testing' stamp: 'TC 11/14/2021 22:41:27'!
nombreEsIgual: unNombre
	^nombreCarpeta = unNombre.! !

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
	instanceVariableNames: 'listaDeUsuarios usuarioLogueado userLogueado carpetaActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'initialization' stamp: 'TC 11/14/2021 22:05:54'!
initialize

	| defaultUserRoot |
	defaultUserRoot _ RootUser conNombre: 'root' yContraseña: 'root'.
	listaDeUsuarios _ Set new .
	listaDeUsuarios add: defaultUserRoot .	
	carpetaActual _ Folder conNombre: 'root'
	! !

!Terminal methodsFor: 'initialization' stamp: 'dk 11/14/2021 20:26:56'!
initializeIniciarSesion: unUser 

	self iniciarSesion: unUser .
	
	! !


!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:57:33'!
estaElUsuarioLogueado: unUser 

	^ unUser esIgualElUserYContraseñaA: usuarioLogueado ! !

!Terminal methodsFor: 'testing' stamp: 'TC 11/14/2021 22:07:46'!
estaParadaEnElDirectorioRaiz
	^ 'root' = carpetaActual nombre.! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:30:32'!
tieneAlUsuario: unUser 

	^ listaDeUsuarios includes: unUser .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:58:39'!
tieneAlUsuarioLogueado: unUsuario 
	^ (self tieneUnUsuarioLogueado) & (self estaElUsuarioLogueado: unUsuario) .! !

!Terminal methodsFor: 'testing' stamp: 'TC 11/14/2021 22:25:35'!
tieneCarpetasEnElDirectorioActual
	^ carpetaActual tieneCarpetas.! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:30:48'!
tieneUnUsuarioLogueado

	^ usuarioLogueado notNil ! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:33:35'!
unUsuarioTieneElMismoNombreQue: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | (unUserEnLaLista nombreEsIgual: unUser nombre)]! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/14/2021 20:34:13'!
unUsuarioTieneElMismoNombreYContraseñaQue: unUser

	^ listaDeUsuarios anySatisfy: [:unUserEnLaLista | unUserEnLaLista esIgualElUserYContraseñaA: unUser]! !


!Terminal methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:37:07'!
borrarUsuario: unUser 

	listaDeUsuarios remove: unUser 
		ifAbsent: [self errorUsuarioNoExistente]! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:36:54'!
ingresarUsuario: unUserAIngresar
	
	(self unUsuarioTieneElMismoNombreQue: unUserAIngresar) 
		ifTrue: [self errorContraseñaOUsuarioIncorrecto] 
		ifFalse: [listaDeUsuarios add: unUserAIngresar].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:37:00'!
iniciarSesion: unUserALoguease 
	
	(self unUsuarioTieneElMismoNombreYContraseñaQue: unUserALoguease) 
		ifTrue: [usuarioLogueado _ unUserALoguease] 
		ifFalse: [self errorContraseñaOUsuarioIncorrecto].! !

!Terminal methodsFor: 'public actions' stamp: 'TC 11/14/2021 22:40:17'!
mkdir: unaCarpeta

	|listaDeCarpetasEnElDirectorioActual|
	listaDeCarpetasEnElDirectorioActual _ carpetaActual listaDeCarpetas.
	
	(listaDeCarpetasEnElDirectorioActual anySatisfy: [:unaCarpetaEnLaLista | (unaCarpetaEnLaLista nombreEsIgual:  unaCarpeta nombre)]) 
		ifTrue: [self error: 'La carpeta ya existe en este directorio'.] 
		ifFalse: [carpetaActual agregarCarpeta: unaCarpeta.].! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/14/2021 20:37:12'!
modificarUsuario: unUserAModificar por: unUserConModificaciones 

	(self unUsuarioTieneElMismoNombreQue: unUserAModificar) 
		ifTrue: [
			self ingresarUsuario: unUserConModificaciones .
			self borrarUsuario: unUserAModificar .
		] ifFalse: [
			self errorUsuarioNoExistente
		].! !


!Terminal methodsFor: 'accessing' stamp: 'dk 11/14/2021 20:24:09'!
errorContraseñaOUsuarioIncorrecto

	^ self error: 'El nombre y/o contraseña es incorrecta'! !

!Terminal methodsFor: 'accessing' stamp: 'dk 11/14/2021 20:25:58'!
errorUsuarioNoExistente

	^ self error: 'El usuario no existe'! !

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
