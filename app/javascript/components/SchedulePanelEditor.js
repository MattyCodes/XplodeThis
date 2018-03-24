import React from "react"
import PropTypes from "prop-types"

class SchedulePanelEditor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentSpeakers: this.props.currentSpeakers,
      addPanelOpen: false
    };
  };

  render () {
    let currentSpeakers = this.generateCurrentSpeakers();
    let addSpeakerPanel = this.generateAddSpeakerPanel();

    return (
      <div className="container">
        <div className="col-sm-12 col-md-12 col-lg-12">
          <button className="btn-lg btn-info btn-rounded" style={{ margin: "30px 0px" }} onClick={ (e) => this.openAddPanel(e) }>Add a Speaker</button>
          { addSpeakerPanel }
          <div className="panel panel-body">
            <h3> Panel Speakers </h3>
            { currentSpeakers }
          </div>
        </div>
      </div>
    );
  };

  openAddPanel(e = null) {
    if (e) e.preventDefault();
    this.setState({ addPanelOpen: true });
  };

  generateAddSpeakerPanel() {
    let self = this;
    var panel;

    if ( this.state.addPanelOpen == true ) {
      let options = this.props.speakers.map(function(speaker, index) {
        return (
          <option key={ "new-speaker-" + index } value={ speaker.id }> { speaker.name + " | " + speaker.slug } </option>
        )
      });

      panel = (
        <div className="panel panel-body">
          <select id="panelSpeaker" style={{ width: '100%', maxWidth: '500px', background: '#FFF', height: '40px' }}>
            { options }
          </select>
          <button className="btn-lg btn-info btn-rounded" style={{ display: 'block', margin: '20px auto' }} onClick={ (e) => self.addSpeaker(e) }> Add Speaker </button>
        </div>
      )
    }

    return panel;
  };

  addSpeaker(e = null) {
    if (e) e.preventDefault();
    let self    = this;
    let panelId = this.props.panelId;
    let value   = $("#panelSpeaker").val();

    if (value) {
      $.ajax({
        method: "post",
        url: "/schedule_panels/" + panelId + "/add_speaker",
        data: { speakerId: value }
      }).done(function(res) {
        if (res.success) {
          self.setState({ currentSpeakers: res.speakers });
        } else {
          alert("Something went wrong and this speaker could not be added, please refresh and try again.");
        }
      }).fail(function(err) {
        window.location.reload();
      });
    }
  };

  generateCurrentSpeakers() {
    let self  = this;
    let panel = <span></span>;
    if ( this.state.currentSpeakers && this.state.currentSpeakers.length > 0 ) {
      panel = self.state.currentSpeakers.map(function(speaker, index) {
        return (
          <div key={ "current-speakers-" + index }>
            <img src={ speaker.avatar_url } width="200px" height="200px" style={{ borderRadius: '5px', margin: '25px 0px', objectFit: 'cover' }} />
            <h4> { speaker.name } </h4>
            <h4> { speaker.title } </h4>
            <h4> { "URL: " + speaker.slug } </h4>
            <button className="btn-lg btn-danger btn-rounded" style={{ margin: "30px 0px" }} onClick={ (e) => self.removeSpeaker(speaker.id, e) }> Remove Speaker </button>
          </div>
        )
      });
    } else {
      panel = (
        <div className="text-center">
          <h2> This Panel Has No Speakers. </h2>
        </div>
      )
    }

    return panel;
  };

  removeSpeaker(id, e = null) {
    let panelId = this.props.panelId;
    let self    = this;
    if (e) e.preventDefault();

    $.ajax({
      method: "post",
      url: "/schedule_panels/" + panelId + "/remove_speaker",
      data: { speakerId: id }
    }).done(function(res) {
      if (res.success) {
        self.setState({ currentSpeakers: res.speakers });
      } else {
        alert("Something went wrong and the speaker could not be removed.");
      }
    }).fail(function(err) {
      window.location.reload();
    });
  };
};

export default SchedulePanelEditor
