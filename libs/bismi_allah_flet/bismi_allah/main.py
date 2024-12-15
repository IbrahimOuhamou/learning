# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed Rassoul Allah
import flet as ft


def main(page: ft.Page):
    page.title = "بسم الله الرحمن الرحيم"
    page.window.frameless = True

    def countUp(e):
        button_counter.text = str(int(button_counter.text) + 1)
        page.update()

    text_remembrance = ft.Text(value="سبحان الله وبحمده")
    button_counter = ft.ElevatedButton(text="0", on_click=countUp)

    page.add(
        ft.Column(
            [
                text_remembrance,
                button_counter,
            ],
        )
    )


ft.app(main)
