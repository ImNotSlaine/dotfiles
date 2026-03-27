import app from "ags/gtk4/app"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import Workspaces from "./components/Workspaces"

export default function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
	let win: Astal.Window
	const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
 
	return (
		<window
			$={ (self) => (win = self)}
			visible
			class="bar-container"
			gdkmonitor={gdkmonitor}
			anchor={TOP | LEFT | RIGHT}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			application={app}
		>
			<box class="bar">
				<box class="bar-left" hexpand>
				</box>
				<box class="bar-center" hexpand halign="center">
					<box class="out">
							<Workspaces />
					</box> 
				</box>
				<box class="bar-right">
				</box>
			</box>
		</window>
	)
}
