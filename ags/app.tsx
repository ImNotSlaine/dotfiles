import app from "ags/gtk4/app"
import main from "./styles/main.scss"
import Bar from "./widgets/bar/Bar"
import { createBinding, For, This } from "ags"

app.start({
	css: main,

	main() {
		const monitors = createBinding(app, "monitors");

		return (
			<For each={monitors}>
				{ (gdkmonitor) => (
					<This this={app}>
						<Bar gdkmonitor={gdkmonitor} />
					</This>
				)}
			</For>
		)
	},
})
