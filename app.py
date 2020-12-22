import numpy as np
import pandas as pd

from sqlalchemy import create_engine, inspect
from flask import Flask, jsonify
import json

SQL_USERNAME = "postgres"
SQL_PASSWORD = "password"
SQL_IP = "35.239.117.17"
PORT = 5432
DATABASE = "postgres"

connection_string = f"postgresql+psycopg2://{SQL_USERNAME}:{SQL_PASSWORD}@{SQL_IP}:{PORT}/{DATABASE}"
engine = create_engine(connection_string)


inspector = inspect(engine)
print(inspector.get_table_names())

columns = inspector.get_columns("teams")
for c in columns:
    print(c["name"],c["type"])

#########################################################################

app = Flask(__name__)

@app.route("/")
def home():
    print("Client requested the home page from the server")
    return"""<h1>ETL project group 4: NHL skater position data App (Flask API)</h1>
<h3>NHL data tables:</h3>
<p>Team(To look for individual division teams,please put the division id# in the end to show all the teams in that division):</p>
<ul>
   <li><a href="/teams/">/teams/</a></li>
 </ul>
 <p>Conference:</p>
 <ul>
   <li><a href="/conference">/conference</a></li>
 </ul>
 <p>Division:</p>
 <ul>
   <li><a href="/division">/division</a></li>
 </ul>
 <p>Player:</p>
 <ul>
   <li><a href="/player">/player</a></li>
 </ul>
 <p>Player Stats:</p>
 <ul>
   <li><a href="/playerstats">/playerstats</a></li>
 </ul>"""


@app.route("/teams/")
def get_all_teams():
    query = """
            SELECT
                *
            FROM
                teams
            """

    conn = engine.connect()
    df = pd.read_sql(query, con=conn)
    conn.close()

    return jsonify(json.loads(df.to_json(orient="records")))

@app.route("/conference")
def get_all_conference():
    query = """
            SELECT
                *
            FROM
                lk_conference
            """

    conn = engine.connect()
    df = pd.read_sql(query, con=conn)
    conn.close()

    return jsonify(json.loads(df.to_json(orient="records")))

@app.route("/division")
def get_all_division():
    query = """
            SELECT
                *
            FROM
                lk_division
            """

    conn = engine.connect()
    df = pd.read_sql(query, con=conn)
    conn.close()

    return jsonify(json.loads(df.to_json(orient="records")))

@app.route("/player")
def get_all_player():
    query = """
            SELECT
                *
            FROM
                player
            """

    conn = engine.connect()
    df = pd.read_sql(query, con=conn)
    conn.close()

    return jsonify(json.loads(df.to_json(orient="records")))

@app.route("/playerstats")
def get_all_player_stats():
    query = """
            SELECT
                *
            FROM
                player_stats
            """

    conn = engine.connect()
    df = pd.read_sql(query, con=conn)
    conn.close()

    return jsonify(json.loads(df.to_json(orient="records")))

@app.route("/teams/<div_id>")
def get_division(div_id):
    query = f"""
            SELECT
                t.division_id,
                lkd.division_name,
                t.city,
                t.team_name
            FROM
                teams t
            JOIN lk_division lkd on t.division_id=lkd.id
            WHERE
                t.division_id = {div_id}

    """
            
    conn = engine.connect()
    df = pd.read_sql(query, con=conn)
    conn.close()

    return jsonify(json.loads(df.to_json(orient="records")))




if __name__ == "__main__":
    app.run(debug=True)

