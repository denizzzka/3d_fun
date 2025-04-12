import dagon;
import joltphysics;
import std.stdio;

class TestScene: Scene
{
    MyGame game;
    OBJAsset aOBJSuzanne;
    Entity eBox;

    this(MyGame game)
    {
        super(game);
        this.game = game;
    }

    override void beforeLoad()
    {
    }

    override void afterLoad()
    {
        game.deferredRenderer.ssaoEnabled = true;
        game.deferredRenderer.ssaoPower = 6.0;
        game.postProcessingRenderer.tonemapper = Tonemapper.Filmic;
        game.postProcessingRenderer.fxaaEnabled = true;

        auto camera = addCamera();
        auto freeview = New!FreeviewComponent(eventManager, camera);
        freeview.setZoom(5);
        freeview.setRotation(30.0f, -45.0f, 0.0f);
        freeview.translationStiffness = 0.25f;
        freeview.rotationStiffness = 0.25f;
        freeview.zoomStiffness = 0.25f;
        game.renderer.activeCamera = camera;

        auto sun = addLight(LightType.Sun);
        sun.shadowEnabled = true;
        sun.energy = 10.0f;
        sun.pitch(-45.0f);

        auto matBox = addMaterial();
        matBox.baseColorFactor = Color4f(1.0, 0.2, 0.2, 1.0);

        eBox = addEntity();
        eBox.drawable = New!ShapeBox(Vector3f(1, 1, 1), assetManager);
        eBox.material = matBox;
        eBox.position = Vector3f(0, 1, 0);
        eBox.rotation = rotationQuaternion(Vector3f(0, 1, 0), 0.0);

        auto ePlane = addEntity();
        ePlane.drawable = New!ShapePlane(10, 10, 1, assetManager);
    }

    override void onUpdate(Time t)
    {
		immutable rotSpeed = 1.5f;

		static float rotAngle = 0;
		rotAngle += rotSpeed * t.delta;

		eBox.rotation = rotationQuaternion(Vector3f(0, 1, 0), rotAngle);
	}

    //~ override void onKeyDown(int key) { }
    //~ override void onKeyUp(int key) { }
    //~ override void onTextInput(dchar code) { }
    //~ override void onMouseButtonDown(int button) { }
    //~ override void onMouseButtonUp(int button) { }
    //~ override void onMouseWheel(int x, int y) { }
    //~ override void onJoystickButtonDown(int btn) { }
    //~ override void onJoystickButtonUp(int btn) { }
    //~ override void onJoystickAxisMotion(int axis, float value) { }
    //~ override void onResize(int width, int height) { }
    //~ override void onFocusLoss() { }
    //~ override void onFocusGain() { }
    //~ override void onDropFile(string filename) { }
    //~ override void onUserEvent(int code) { }
    //~ override void onQuit() { }
}

class MyGame: Game
{
    this(uint w, uint h, bool fullscreen, string title, string[] args)
    {
        super(w, h, fullscreen, title, args);
        currentScene = New!TestScene(this);
    }
}

void main(string[] args)
{
    MyGame game = New!MyGame(1280, 720, false, "Header_Header", args);
    game.run();
    Delete(game);
}
