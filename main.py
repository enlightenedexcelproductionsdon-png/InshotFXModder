import os
import shutil
import pyglet
from pyglet import gl
from pyglet.window import key
import math

EFFECT_IDS = [
    "74926486347",
    "74926484847",
    "75038362347",
    "7508462946",
    "7505937493"
]

RESOURCE_FOLDER = os.path.join(
    os.path.expanduser("~"),
    "Movies",
    "InShot",
    "User Data",
    "Cache",
    "Effects"
)

CATEGORY_DISTORT = "distort"
CATEGORY_BASIC = "basic"

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

class Effect:
    def __init__(self, effect_id, category):
        self.effect_id = effect_id
        self.category = category

    def apply(self, image, time_value):
        pass

class DistortWaveEffect(Effect):
    def __init__(self, effect_id):
        super().__init__(effect_id, CATEGORY_DISTORT)

    def apply(self, image, time_value):
        return image

class BasicEffect(Effect):
    def __init__(self, effect_id):
        super().__init__(effect_id, CATEGORY_BASIC)

    def apply(self, image, time_value):
        return image

def copy_effect_resources():
    if not os.path.exists(RESOURCE_FOLDER):
        os.makedirs(RESOURCE_FOLDER)
    for eid in EFFECT_IDS:
        src = os.path.join(RESOURCE_FOLDER, eid)
        dst = os.path.join(RESOURCE_FOLDER, eid + "_copy")
        if os.path.exists(src):
            if os.path.exists(dst):
                shutil.rmtree(dst)
            shutil.copytree(src, dst)

effects = []
for eid in EFFECT_IDS:
    if eid in EFFECT_IDS[:3]:
        effects.append(DistortWaveEffect(eid))
    else:
        effects.append(BasicEffect(eid))

window = pyglet.window.Window(WINDOW_WIDTH, WINDOW_HEIGHT, "InShot Modder Effects")

label = pyglet.text.Label(
    "InShot Effects Loader",
    x=10,
    y=WINDOW_HEIGHT - 20
)

time_value = 0.0

@window.event
def on_draw():
    global time_value
    window.clear()
    label.draw()
    gl.glBegin(gl.GL_QUADS)
    gl.glVertex2f(100 + math.sin(time_value) * 50, 100)
    gl.glVertex2f(200 + math.sin(time_value) * 50, 100)
    gl.glVertex2f(200 + math.sin(time_value) * 50, 200)
    gl.glVertex2f(100 + math.sin(time_value) * 50, 200)
    gl.glEnd()

def update(dt):
    global time_value
    time_value += dt

pyglet.clock.schedule_interval(update, 1/60.0)

copy_effect_resources()

pyglet.app.run()
