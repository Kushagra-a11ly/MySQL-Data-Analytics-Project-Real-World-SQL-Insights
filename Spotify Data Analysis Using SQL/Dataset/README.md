🎵 Spotify Dataset 

📌 Overview

This repository contains a structured and analysis-ready Spotify music dataset, designed for exploring patterns in songs, artists, audio features, popularity, and engagement behavior.

It is ideal for SQL projects, analytics portfolios, machine learning models, BI dashboards, and academic research.

🎯 Purpose of the Dataset

The dataset enables deep exploration of:

🔥 Track popularity & engagement

🎧 Genre characteristics & trends

👨‍🎤 Artist growth and performance

🎼 Audio feature patterns (danceability, energy, valence, etc.)

📊 Correlation & clustering analysis

🤖 Recommendation systems

📅 Time-based listening trends

📂 Data Source

All information is derived from publicly available Spotify metadata and processed into a clean, structured dataset ready for use.

📑 File Description (Column Dictionary)

Column	Type	Description

🎤 Artist	text	Performer of the track

🎵 Track	text	Name of the track

💿 Album	text	Album or EP title

🔖 Album_type	text	Single, album, compilation

💃 Danceability	double	How suitable a track is for dancing

⚡ Energy	double	Intensity & activity level

🔊 Loudness	double	dB value

🗣 Speechiness	double	Spoken content score

🎻 Acousticness	double	Acoustic score

🎹 Instrumentalness	double	Instrumental likelihood

🎙 Liveness	double	Live performance probability

😀 Valence	double	Positivity / happiness score

⏱ Tempo	double	Beats per minute

🕒 Duration_min	double	Song length in minutes

👀 Views	int	YouTube views

👍 Likes	int	YouTube likes

💬 Comments	int	Comment count

✔ Licensed	text	Whether track is licensed

🎥 official_video	text	Whether it has an official MV

🔁 Stream	double	Spotify stream count

🎚 EnergyLiveness	double	Combined metric

🏆 most_playedon	text	Platform with highest engagement

🧭 Project Structure

Spotify Data Analysis Using SQL/
│── Dataset/
│── Queries/
│── Results/
│── README.md

🗄 Database Setup (MySQL)


CREATE DATABASE spotify;

USE spotify;

RENAME TABLE spotify dataset TO spotify_dataset;


🔍 Recommended Analyses

📈 Track popularity trends

🎧 Genre-wise comparisons

👨‍🎤 Top artists & albums

🎼 Audio feature clustering

🔗 Correlation heatmaps

🕒 Time-series trends

🤖 Basic recommendation modeling

📊 KPI dashboards (Power BI / Tableau)

🚀 Use Cases

Perfect for:

Data Analyst portfolios

BI dashboards

SQL practice

ML model training

Music research

LinkedIn portfolio posts

YouTube tutorial projects

📜 License

This dataset is provided strictly for educational and research use.

📫 Contact
Kushagra Mukund Dhamani
