import app from "astal/gtk4/app"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gtk?version=4.0"
import Hyprland from "gi://AstalHyprland"
import { For, createState } from "ags"

const hypr = Hyprland.get_default()

const wsIcons = {
	1: "󰲠 ",
	2: "󰲢 ",
	3: "󰲤 ",
	4: "󰲦 ",
	5: "󰲨 ",
	6: "󰲪 ",
	7: "󰲬 ",
	8: "󰲮 ",
	9: "󰲰 ",
};

function getLabel(ws) {
	if (ws.id < 0) return " ";
	return wsIcons[ws.id] || ws.id.toString();
}

export default function Workspaces() {
	const [workspaces, setWorkspaces] = createState(hypr.workspaces);
	
	hypr.connect("notify::workspaces", () => {
		setWorkspaces(hypr.workspaces);
	});

	console.log(workspaces);
	console.log(workspaces());
	return (
		<box class="workspaces" halign="center">
			<For each={workspaces}>
				{(ws) => (
					<button
						visible={
							ws.monitor !== -1 ||
							ws.clients.lenght > 0 ||
							(ws.id < 0 && ws.clients.lenght > 0)
						}
						class={ws.active ? "workspace active" : "workspace"}
						onClicked={() => 
							hypr.dispatch("workspace", ws.id.toString())
						}
					>
						{getLabel(ws)}
					</button>
				)}
			</For>
		</box>
	);
}
