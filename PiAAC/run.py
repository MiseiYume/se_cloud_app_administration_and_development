from flask import Flask, render_template
import sentry_sdk
from sentry_sdk.integrations.flask import FlaskIntegration


sentry_sdk.init(
    dsn = "https://eb5f3e4658bf45e6b8880040847cd225@o1215926.ingest.sentry.io/6357816",
    integrations = [FlaskIntegration()],
    traces_sample_rate = 1.0
)

app = Flask(__name__)

@app.route("/")
def aboutme():
    return render_template('aboutme.html')


@app.route("/gallery.html")
def gallery():
    return render_template('gallery.html')


@app.route("/contact.html")
def contact():
    return render_template('contact.html')


@app.route("/guestbook.html")
def guestbook():
    return render_template('guestbook.html')


@app.route('/error_internal')
def error_internal():
    return render_template('template.html', name = 'ERROR 505'), 505


@app.errorhandler(404)
def not_found_error(error):
    return render_template('404.html'), 404


# Control check of the Sentry functionality
# @app.route('/debug-sentry')
# def trigger_error():
#     division_by_zero = 1 / 0


if __name__ == '__main__':
    app.run(host = '0.0.0.0', debug = True)
