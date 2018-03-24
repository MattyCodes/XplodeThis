import React from "react"
import PropTypes from "prop-types"

class SchedulePanelSelector extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentPanels: this.props.currentPanels,
      showCreatePanel: false,
      speakerSelects: []
    };
  };

  render () {
    let createPanel    = this.generateCreatePanel( this.state.showCreatePanel );
    let createButton   = this.generateCreateButton( this.state.showCreatePanel );
    let currentPanels  = this.generateCurrentPanels( this.state.currentPanels );

    return (
      <div className="container">
        <div className="row">
          { createPanel }
          <div className="col-sm-12 col-md-4 col-lg-4">
            { createButton }
          </div>
        </div>
        <div className="row">
          <div className="col-sm-12 col-md-12 col-lg-12" style={{ marginTop: '50px' }}>
            <h2 style={{ margin: "35px 0px" }}> Current Panels: </h2>
            { currentPanels }
          </div>
        </div>
      </div>
    );
  };

  showCreatePanel(e = null) {
    if (e) e.preventDefault();
    this.addSpeakerSelect();
    this.setState({ showCreatePanel: true });
  };

  hideCreatePanel(e = null) {
    if (e) e.preventDefault();
    this.setState({ showCreatePanel: false, speakerSelects: [] });
  };

  addSpeakerSelect(e = null) {
    if (e) e.preventDefault()

    let selectStyle = {
      width: '90%',
      background: '#ffffff',
      height: '40px',
      margin: '10px 0px'
    };

    let options = this.props.speakers.map(function(speaker, index) {
      return (
        <option key={ "speaker-option " + index } value={ speaker.id }> { speaker.name + " (" + speaker.slug + ")" } </option>
      )
    });

    let newSelect = <select key={ "speaker-select " + ( this.state.speakerSelects.length + 1 ) } name="speaker" className="panelSpeaker" style={ selectStyle }> { options } </select>;
    this.setState({ speakerSelects: this.state.speakerSelects.concat(newSelect) });
  };

  removeSpeakerSelect(e = null) {
    if (e) e.preventDefault();
    var speakerSelects = this.state.speakerSelects.slice(0);
    speakerSelects.splice(-1, 1);
    this.setState({ speakerSelects: speakerSelects });
  };

  generateCreateButton(panelVisible) {
    var button;

    if ( panelVisible == true ) {
      button = ( <button className="btn-lg btn-success btn-rounded" onClick={ (e) => this.submitCurrentPanel(e) }> Save Panel </button> )
    } else {
      button = ( <button className="btn-lg btn-info btn-rounded" onClick={ (e) => this.showCreatePanel(e) }> Add a Panel </button> )
    }

    return button;
  };

  generateCreatePanel(panelVisible) {
    var panel;
    var inputStyle = {
      border: '1px solid #d3d3d3',
      padding: '10px'
    }

    if ( panelVisible == true ) {
      panel = (
        <div className="col-sm-12 col-md-8 col-lg-8">
          <div className="panel panel-body">
            <label>Session Time</label>
            <input type="text" name="time" id="panelTime" placeholder="9:00am" style={ inputStyle } />
            <label>Session Title</label>
            <input type="text" name="time" id="panelTitle" placeholder="Welcome and Speaker Introductions" style={ inputStyle } />
            <label>Session Speakers</label>
            { this.state.speakerSelects }
            <button className="btn-lg btn-info btn-rounded" style={{ margin: "25px 0px" }} onClick={ (e) => this.addSpeakerSelect(e) }> Add another Speaker </button>
            <button className={ "btn-lg btn-danger btn-rounded " + ( this.state.speakerSelects.length > 1 ? 'show' : 'hide' ) } style={{ margin: "5px auto" }} onClick={ (e) => this.removeSpeakerSelect(e) }> Remove a Speaker </button>
          </div>
        </div>
      )
    }

    return panel;
  };

  generateCurrentPanels(panels) {
    var self = this;
    var res;

    if ( panels.length > 0 ) {
      res = panels.map(function(panel, index) {
        let speakers = <h4> There are no speakers. </h4>;
        if ( panel.speakers.length > 0 ) {
          speakers = panel.speakers.map(function(speaker, index) {
            return (
              <div key={ "speaker-" + speaker.id + "-" + index }>
                <p> { speaker.name } </p>
                <p> { speaker.title } </p>
                <p> { "URL: " + speaker.slug } </p>
                <img src={ speaker.avatar_url } width="200px" height="200px" style={{ objectFit: 'cover', borderRadius: '5px', margin: '15px 0px' }} />
                <hr />
              </div>
            )
          });
        }

        return (
          <div className="row" key={ "panel-preview " + index }>
            <div className="col-sm-12 col-md-12 col-lg-12">
              <div className="panel panel-body">
                <h3> { "Time: " + panel.time } </h3>
                <h3> { "Title: " + panel.title } </h3>
                <hr />
                <h3> Speakers: </h3>
                { speakers }
                <div style={{ margin: '40px 0px 20px 0px' }}>
                  <a href={ "/schedule_panels/" + panel.id + "/edit" } style={{ margin: "20px 0px" }} className="btn-lg btn-warning btn-rounded"> Edit Session Panel </a>
                  <button className="btn-lg btn-danger btn-rounded" style={{ margin: "20px 10px" }} onClick={ (e) => self.deletePanel(panel.id, e) }> Delete Session Panel </button>
                </div>
              </div>
            </div>
          </div>
        )
      });
    } else {
      res = (
        <div className="panel panel-body">
          <h3>There are no session-panels.</h3>
        </div>
      );
    }
    return res;
  };

  deletePanel(id, e = null) {
    if (e) e.preventDefault();
    let self = this;

    $.ajax({
      method: "delete",
      url: "/schedule_panels/" + id
    }).done(function(res) {
      if (res.success) {
        self.setState({ currentPanels: res.panels });
      } else {
        alert("Something went wrong and the panel could not be removed. Please refresh and try again.");
      }
    }).fail(function(err) {
      window.location.reload();
    });
  };

  submitCurrentPanel(e = null) {
    if (e) e.preventDefault();

    let self       = this;
    let scheduleId = this.props.scheduleId;
    let time       = $("#panelTime").val();
    let title      = $("#panelTitle").val();
    let speakers   = $(".panelSpeaker").map(function() {
      return $(this).val();
    }).get();

    if ( time && title && speakers ) {
      $.ajax({
        method: "POST",
        url: "/schedule_panels",
        data: { time: time, title: title, speaker_ids: speakers, scheduleId: scheduleId }
      }).done(function(res) {
        self.setState({ currentPanels: res.panels })
        self.hideCreatePanel();
      }).fail(function(err) {
        window.location.reload();
      });
    }
  };

};

export default SchedulePanelSelector
