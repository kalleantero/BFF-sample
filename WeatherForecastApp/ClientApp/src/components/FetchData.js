import React, { Component } from 'react';

export class FetchData extends Component {
  static displayName = FetchData.name;

  constructor(props) {
    super(props);
      this.state = { forecasts: [], loading: true };
      this.baseState = this.state
    }

  componentDidMount() {
    this.populateWeatherData();
  }

  static renderForecastsTable(forecasts) {
    return (
      <table className='table table-striped' aria-labelledby="tabelLabel">
        <thead>
          <tr>
            <th>Date</th>
            <th>Temp. (C)</th>
            <th>Temp. (F)</th>
            <th>Summary</th>
          </tr>
        </thead>
        <tbody>
          {forecasts.map(forecast =>
            <tr key={forecast.date}>
              <td>{forecast.date}</td>
              <td>{forecast.temperatureC}</td>
              <td>{forecast.temperatureF}</td>
              <td>{forecast.summary}</td>
            </tr>
          )}
        </tbody>
      </table>
    );
    }

    login = () => {
        window.location = "https://localhost:7211/bff/login?returnUrl=/";
    }


  render() {
    let contents = this.state.loading
      ? <p><em>Loading...</em></p>
      : FetchData.renderForecastsTable(this.state.forecasts);

    return (
      <div>
        <h1 id="tabelLabel" >Weather forecast</h1>
            <p>This component demonstrates fetching data from the server.</p>
            <button onClick={this.login}>
                Login first
            </button>
            <br />
            <br />
            {contents}
      </div>
    );
    }

    async populateWeatherData() {
        var req = new Request('/weatherforecast', {
            headers: new Headers({
                'X-CSRF': '1'
            })
        })
        const response = await fetch(req);
        const data = await response.json();
        this.setState({ forecasts: data, loading: false });      
  }
}
