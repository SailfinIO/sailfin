import language.experimental.captureChecking
import caps.*
import tacit.library.*

@assumeSafe object api extends InterfaceImpl("""{"allowedRoots":["."]}""")
@assumeSafe given tacitIO: IOCapability = GlobalIOCap
