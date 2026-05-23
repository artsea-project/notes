"""Generate the spider chart for the ArtSea methodology selection report.

Run from this directory with:
    .venv/bin/python generate_chart.py
"""

from dataclasses import dataclass, field
from math import cos, pi, sin
from pathlib import Path
import os

CHART_DIR = Path(__file__).resolve().parent
os.environ.setdefault("MPLCONFIGDIR", str(CHART_DIR / ".matplotlib-cache"))

import matplotlib.pyplot as plt
import numpy as np

OUTPUT = CHART_DIR / "artsea-methodology-radar.png"

# -----------------------------------------------------------------------------
# Easy-to-edit chart configuration
# -----------------------------------------------------------------------------

FIGURE_SIZE = (9.0, 6.4)
DPI = 220
RADIUS = 1.0
GRID_RADII = [0.18, 0.38, 0.58, 0.78, 0.98]
AXIS_TITLE_RADIUS = 1.18

AXIS_COLOR = "#2b2b2b"
GRID_COLOR = "#d7d7d7"
PROJECT_COLOR = "#16820f"
TEXT_COLOR = "#111111"
NOTE_COLOR = "#444444"
LEADER_COLOR = "#777777"

NOTE = "bliżej środka: cechy bardziej zwinne, dalej od środka: cechy bardziej klasyczne"

# Keep symmetric limits around the logical centre of the spider diagram.
# Text is placed inside these limits, so the exported image remains centered.
X_LIMITS = (-1.65, 1.65)
Y_LIMITS = (-1.40, 1.35)


@dataclass(frozen=True)
class Tick:
    radius: float
    label: str
    # Optional absolute label position. If set, a leader line is drawn from the
    # tick to this point. Useful for long qualitative labels.
    label_xy: tuple[float, float] | None = None


@dataclass(frozen=True)
class AxisSpec:
    key: str
    title: str
    subtitle: str
    angle: float
    ticks: list[Tick]
    value: float
    # Optional absolute title position. If omitted, title is placed on the axis.
    title_xy: tuple[float, float] | None = None
    title_ha: str | None = None
    tick_label_mode: str = (
        "default"  # default | left | along_negative_perp | qualitative
    )


AXES = [
    AxisSpec(
        key="osoby",
        title="Osoby",
        subtitle="% osób",
        angle=pi / 2,
        ticks=[Tick(0.18, "0"), Tick(0.58, "50"), Tick(0.98, "100")],
        value=0.58,
        tick_label_mode="left",
    ),
    AxisSpec(
        key="dynamika",
        title="Dynamika",
        subtitle="% zmian wymagań / mies.",
        angle=pi / 10,
        ticks=[Tick(0.18, "90"), Tick(0.58, "50"), Tick(0.98, "10")],
        value=0.78,
        tick_label_mode="dynamika",
    ),
    AxisSpec(
        key="kultura",
        title="Kultura",
        subtitle="% chaosu vs. porządku",
        angle=-3 * pi / 10,
        ticks=[Tick(0.18, "100"), Tick(0.58, "50"), Tick(0.98, "10")],
        value=0.58,
        tick_label_mode="along_negative_perp",
    ),
    AxisSpec(
        key="rozmiar",
        title="Rozmiar",
        subtitle="liczba osób",
        angle=-7 * pi / 10,
        ticks=[Tick(0.18, "3"), Tick(0.58, "30"), Tick(0.98, "300")],
        value=0.18,
        tick_label_mode="along_negative_perp",
    ),
    AxisSpec(
        key="krytycznosc",
        title="Krytyczność",
        subtitle="straty na skutek defektów",
        angle=pi - pi / 10,
        ticks=[
            Tick(0.18, "drobna uciążliwość", (-0.58, -0.18)),
            Tick(0.38, "umiarkowana strata", (-0.78, -0.02)),
            Tick(0.68, "duża strata", (-0.98, 0.15)),
            Tick(0.98, "zagrożenie życia", (-1.04, 0.33)),
        ],
        value=0.38,
        title_xy=(-1.47, 0.62),
        title_ha="center",
        tick_label_mode="qualitative",
    ),
]

# -----------------------------------------------------------------------------
# Drawing helpers
# -----------------------------------------------------------------------------


def point(angle: float, radius: float) -> np.ndarray:
    """Return x/y coordinates for a polar point."""
    return np.array([cos(angle) * radius, sin(angle) * radius])


def perpendicular(angle: float) -> np.ndarray:
    """Return a unit vector perpendicular to the axis at the given angle."""
    return np.array([-sin(angle), cos(angle)])


def auto_title_alignment(x: float) -> str:
    if x > 0.35:
        return "left"
    if x < -0.35:
        return "right"
    return "center"


def tick_label_position(
    axis: AxisSpec, tick: Tick, tick_xy: np.ndarray, perp: np.ndarray
):
    """Return (xy, ha, va, use_leader_line) for a tick label."""
    if axis.tick_label_mode == "qualitative":
        return np.array(tick.label_xy), "right", "center", True
    if axis.tick_label_mode == "left":
        return tick_xy + np.array([0.10, 0.0]), "left", "center", False
    if axis.tick_label_mode == "dynamika":
        return tick_xy - perp * 0.075 + np.array([0.02, 0.0]), "left", "center", False
    if axis.tick_label_mode == "along_negative_perp":
        return tick_xy - perp * 0.075, "center", "center", False
    return tick_xy, "center", "center", False


def draw_reference_grid(ax):
    for radius in GRID_RADII:
        pts = np.array([point(axis.angle, radius) for axis in AXES])
        pts = np.vstack([pts, pts[0]])
        ax.plot(pts[:, 0], pts[:, 1], color=GRID_COLOR, lw=0.75, zorder=0)


def draw_axis(ax, axis: AxisSpec):
    end = point(axis.angle, RADIUS)
    ax.plot([0, end[0]], [0, end[1]], color=AXIS_COLOR, lw=1.25, zorder=1)

    perp = perpendicular(axis.angle)
    for tick in axis.ticks:
        tick_xy = point(axis.angle, tick.radius)
        tick_len = 0.035
        tick_a = tick_xy - perp * tick_len
        tick_b = tick_xy + perp * tick_len
        ax.plot(
            [tick_a[0], tick_b[0]],
            [tick_a[1], tick_b[1]],
            color=AXIS_COLOR,
            lw=1.0,
            zorder=2,
        )

        label_xy, ha, va, use_leader = tick_label_position(axis, tick, tick_xy, perp)
        if use_leader:
            ax.annotate(
                tick.label,
                xy=tick_xy,
                xytext=label_xy,
                ha=ha,
                va=va,
                fontsize=7.8,
                color=TEXT_COLOR,
                arrowprops=dict(
                    arrowstyle="-", color=LEADER_COLOR, lw=0.8, shrinkA=2, shrinkB=2
                ),
            )
        else:
            ax.text(
                label_xy[0],
                label_xy[1],
                tick.label,
                ha=ha,
                va=va,
                fontsize=8.8,
                color=TEXT_COLOR,
            )

    title_xy = (
        np.array(axis.title_xy)
        if axis.title_xy
        else point(axis.angle, AXIS_TITLE_RADIUS)
    )
    title_ha = axis.title_ha or auto_title_alignment(title_xy[0])
    ax.text(
        title_xy[0],
        title_xy[1] + 0.035,
        axis.title,
        ha=title_ha,
        va="bottom",
        fontsize=13,
        fontweight="bold",
    )
    ax.text(
        title_xy[0],
        title_xy[1] - 0.005,
        f"({axis.subtitle})",
        ha=title_ha,
        va="top",
        fontsize=9.5,
        style="italic",
    )


def draw_project_polygon(ax):
    project_pts = np.array([point(axis.angle, axis.value) for axis in AXES])
    closed = np.vstack([project_pts, project_pts[0]])
    ax.plot(closed[:, 0], closed[:, 1], color=PROJECT_COLOR, lw=2.8, zorder=4)
    ax.scatter(
        project_pts[:, 0],
        project_pts[:, 1],
        s=75,
        color=PROJECT_COLOR,
        edgecolor="white",
        linewidth=1.2,
        zorder=5,
    )


# -----------------------------------------------------------------------------
# Render
# -----------------------------------------------------------------------------

fig, ax = plt.subplots(figsize=FIGURE_SIZE)
fig.patch.set_facecolor("white")
ax.set_facecolor("white")
ax.set_aspect("equal")
ax.axis("off")

for draw in (draw_reference_grid,):
    draw(ax)
for axis in AXES:
    draw_axis(ax, axis)
draw_project_polygon(ax)

ax.text(0.0, -1.28, NOTE, ha="center", va="center", fontsize=9, color=NOTE_COLOR)

ax.set_xlim(*X_LIMITS)
ax.set_ylim(*Y_LIMITS)
fig.savefig(OUTPUT, dpi=DPI)
print(f"Saved {OUTPUT}")
