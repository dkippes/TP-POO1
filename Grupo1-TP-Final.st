!classDefinition: #TerminalTest category: 'Grupo1-TP-Final'!
TestCase subclass: #TerminalTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/12/2021 19:50:15'!
test001_cuandoUnaTerminalSeIniciaComoRoot_estaYaTieneUnUsuarioRootLogueado

	"Setup"
	| terminal |
	terminal _ Terminal iniciarComoUserRoot .
	
	Assert isTrue: terminal tieneUnUsuarioLogueado .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/12/2021 19:56:35'!
test002_cuandoUnaTerminalSeRegistraUnUsuario_esteEsAgregadoALaListaDeUsuarios

	"Setup"
	| terminal unUser |
	unUser _ User initializeConNombre: 'Diego' yContraseña: '1234' .
	terminal _ Terminal new .
	
	"Exercise"
	terminal registrar: unUser .
	
	Assert isTrue: (terminal tieneAlUsuario: unUser) .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/12/2021 20:08:25'!
test003_cuandoUnaTerminalSeIniciaSesionConUnUsuario_esteIniciaSesion

	"Setup"
	| terminal unUser |
	unUser _ User initializeConNombre: 'Diego' yContraseña: '1234' .
	terminal _ Terminal new .
	terminal registrar: unUser .
	
	"Exercise"
	terminal iniciarSesion: unUser .
	
	Assert isTrue: (terminal tieneAlUsuario: unUser) .
	Assert isTrue: terminal tieneUnUsuarioLogueado .! !

!TerminalTest methodsFor: 'terminal_testing' stamp: 'dk 11/12/2021 20:34:43'!
test004_cuandoUnaTerminalSeRegistraConUnUsuario_esteYaExiste

	"Setup"
	| terminal unUser |
	unUser _ User initializeConNombre: 'Diego' yContraseña: '1234' .
	terminal _ Terminal new .
	terminal registrar: unUser .
	
	Assert
        should: [ terminal registrar: unUser  ]
        signal: Error
        withDescription: 'El usuario ya esta registrado' .! !


!classDefinition: #Terminal category: 'Grupo1-TP-Final'!
Object subclass: #Terminal
	instanceVariableNames: 'listaDeUsuarios usuarioLogueado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!Terminal methodsFor: 'initialization' stamp: 'dk 11/12/2021 01:02:46'!
initialize

	listaDeUsuarios _ Set new . ! !

!Terminal methodsFor: 'initialization' stamp: 'dk 11/12/2021 20:04:51'!
initializeIniciarComoUserRoot

	| userRoot |
	userRoot _ UserRoot conNombre: 'root' yContraseña: 'root'.
	usuarioLogueado _ userRoot .
	listaDeUsuarios add: userRoot .! !


!Terminal methodsFor: 'testing' stamp: 'dk 11/12/2021 19:58:18'!
tieneAlUsuario: unUser 

	^ listaDeUsuarios includes: unUser .! !

!Terminal methodsFor: 'testing' stamp: 'dk 11/12/2021 19:52:12'!
tieneUnUsuarioLogueado

	^ usuarioLogueado notNil ! !


!Terminal methodsFor: 'public actions' stamp: 'dk 11/12/2021 20:12:19'!
iniciarSesion: unUserALoguease 
	usuarioLogueado _ listaDeUsuarios detect: [:unUser | unUser esIgualElUserYContraseñaA: unUserALoguease] .! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/12/2021 20:44:11'!
notEstaRegistrado: unUserARegistrarse
	! !

!Terminal methodsFor: 'public actions' stamp: 'dk 11/12/2021 20:47:33'!
registrar: unUserARegistrar
	(listaDeUsuarios anySatisfy: [:unUser | unUser nombreEsIgual: (unUserARegistrar nombre)]) ifTrue: [self error: 'El usuario ya esta registrado'] ifFalse: [listaDeUsuarios add: unUserARegistrar].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Terminal class' category: 'Grupo1-TP-Final'!
Terminal class
	instanceVariableNames: ''!

!Terminal class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 19:43:55'!
iniciarComoUserRoot
	^self new initializeIniciarComoUserRoot! !



!classDefinition: #User category: 'Grupo1-TP-Final'!
Object subclass: #User
	instanceVariableNames: 'nombre contraseña'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!User methodsFor: 'accessing' stamp: 'dk 11/12/2021 00:50:55'!
contraseña
	^contraseña! !

!User methodsFor: 'accessing' stamp: 'dk 11/12/2021 00:50:50'!
nombre
	^nombre! !


!User methodsFor: 'initialization' stamp: 'dk 11/12/2021 19:57:26'!
initializeInitializeConNombre: unNombre yContraseña: unaContraseña 

	nombre := unNombre.
	contraseña := unaContraseña.! !


!User methodsFor: 'testing' stamp: 'dk 11/12/2021 20:15:01'!
contraseñaEsIgual: unaContraseña 
	^ contraseña = unaContraseña ! !

!User methodsFor: 'testing' stamp: 'dk 11/12/2021 20:14:23'!
esIgualElUserYContraseñaA: unUser 
	^ (self nombreEsIgual: unUser nombre) & (self contraseñaEsIgual: unUser contraseña)! !

!User methodsFor: 'testing' stamp: 'dk 11/12/2021 20:14:46'!
nombreEsIgual: unNombre 
	^ nombre = unNombre ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'User class' category: 'Grupo1-TP-Final'!
User class
	instanceVariableNames: ''!

!User class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 19:57:05'!
initializeConNombre: unNombre yContraseña: unaContraseña
	^self new initializeInitializeConNombre: unNombre yContraseña: unaContraseña ! !


!classDefinition: #UserRoot category: 'Grupo1-TP-Final'!
Object subclass: #UserRoot
	instanceVariableNames: 'nombre contraseña'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Grupo1-TP-Final'!

!UserRoot methodsFor: 'initialization' stamp: 'dk 11/12/2021 00:45:32'!
initializeConNombre: unNombre yContraseña: unaContraseña 
	nombre := unNombre.
	contraseña := unaContraseña.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UserRoot class' category: 'Grupo1-TP-Final'!
UserRoot class
	instanceVariableNames: ''!

!UserRoot class methodsFor: 'instance creation' stamp: 'dk 11/12/2021 00:45:03'!
conNombre: unNombre yContraseña: unaContraseña 
	^self new initializeConNombre: unNombre yContraseña: unaContraseña ! !
