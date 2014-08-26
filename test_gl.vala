// build glfx3 : cmake -G"MSYS Makefiles" -D=BUILD_SHARED_LIBS
// w32api-4.0.3-1-mingw32-dev.tar.lzma
// valac --pkg glfw3 --pkg gl  -X -I/opt/include -X -lglfw3 -X -lopengl32 -X -lgdi32    test_gl.vala

using GLFW3;
using GL;


void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}

public static int main () {

    bool running = true;

    // Initialize GLFW
    glfwInit ();
    GLFWwindow* window =  glfwCreateWindow(640, 480, "Simple example", null, null);


    glfwMakeContextCurrent(window);

    glfwSetKeyCallback(window, key_callback);

    // Main loop
    while (!glfwWindowShouldClose(window)) {
        // OpenGL rendering goes here...

        float ratio;
        int width = 0; int height = 0;

        glfwGetFramebufferSize(window, &width, &height);
        ratio = width / (float) height;

        glViewport(0, 0, width, height);
        glClear(GL_COLOR_BUFFER_BIT);

        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        glOrtho(-ratio, ratio, -1.0f, 1.0f, 1.0f, -1.0f);
        glMatrixMode(GL_MODELVIEW);

        glLoadIdentity();
        glRotatef((float) glfwGetTime() * 50.0f, 0.0f, 0.0f, 1.0f);

        glBegin(GL_TRIANGLES);
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex3f(-0.6f, -0.4f, 0.0f);
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex3f(0.6f, -0.4f, 0.0f);
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex3f(0.0f, 0.6f, 0.0f);
        glEnd();

        // Swap front and back rendering buffers
        glfwSwapBuffers (window);
        // Check if ESC key was pressed or window was closed
        glfwPollEvents();        
    }

    // Close window and terminate GLFW
    glfwTerminate ();

    // Exit program
    return 0;
}
