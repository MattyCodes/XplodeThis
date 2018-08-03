import React from "react"
import PropTypes from "prop-types"

class SponsorLogoSelector extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      logos: this.props.logos,
      draggingLogo: null
    };
  };

  render () {
    var currentLogos   = this.generateList('current');
    var availableLogos = this.generateList('available');

    return (
      <div className="row" style={{ marginTop: '30px' }}>
        <div className="col-xs-12 col-sm-6 col-md-6 col-lg-6">
          <h2 className="form-header"> Selected Logos </h2>
          { currentLogos }
        </div>
        <div className="col-xs-12 col-sm-6 col-md-6 col-lg-6">
          <h2 className="form-header"> Available Logos </h2>
          { availableLogos }
        </div>
        <div className="col-sm-12 col-md-12 col-lg-12">
          <button className="btn btn-lg btn-primary btn-rounded" onClick={ () => this.submitLogos() }>
            Save Logos
          </button>
        </div>
      </div>
    );
  };

  handleDrag(e) {
    e.stopPropagation();
    e.preventDefault();
  };

  updateDraggingLogo(e, logo) {
    this.setState({ draggingLogo: logo });
  };

  droppedBefore(e, nextLogo) {
    let selected      = nextLogo.selected;
    let prevLogo      = this.state.draggingLogo;
    let theseLogos    = [];
    let thoseLogos    = [];

    this.state.logos.map(function(logo) {
      if ( logo.selected == selected ) {
        theseLogos.push(logo);
      } else {
        thoseLogos.push(logo);
      };
    });

    let prevLogoIndex = null;
    let nextLogoIndex = theseLogos.indexOf(nextLogo);
    let logoInArray   = ( theseLogos.indexOf(prevLogo) != -1 );

    prevLogo['selected'] = selected;

    if ( logoInArray ) {
      prevLogoIndex = theseLogos.indexOf(prevLogo);
      theseLogos.splice(prevLogoIndex, 1);
      theseLogos.splice(nextLogoIndex, 0, prevLogo);
    } else {
      prevLogoIndex = thoseLogos.indexOf(prevLogo);
      thoseLogos.splice(prevLogoIndex, 1);
      theseLogos.splice(nextLogoIndex, 0, prevLogo);
    };

    this.setState({ logos: ( theseLogos.concat(thoseLogos) ) });
  };

  droppedAfter(e, prevLogo) {
    // let prevLogo = this.state.draggingLogo;
    // let allLogos = this.state.logos;
    // let index    = ( allLogos.indexOf(nextLogo) - 1 );
    //
    // allLogos.splice(index, 0, prevLogo);
    //
    // debugger;
  };

  dropSelect(e) {
    debugger;
  };

  dropUnselect(e) {
    debugger;
  };

  arraymove(arr, fromIndex, toIndex) {
    let element = arr[fromIndex];
    arr.splice(fromIndex, 1);
    arr.splice(toIndex, 0, element);
  };

  generateList(logoType) {
    var self      = this;
    var logos     = this.state.logos;
    var selected  = false;
    var available = false;
    var result    = logos.map(function(logo, index) {
      selected  = ( logo && logoType == 'current' && logo.selected );
      available = ( logo && logoType == 'available' && !logo.selected );

      if ( selected || available ) {
        return (
          <div key={ logoType + logo.id + index }>
            <div
              className="droppable"
              onDrop={ (e) => self.droppedBefore(e, logo) }
              onDragOver={ (e) => self.handleDrag(e) }
              style={{ height: '50px' }}
            >
            </div>
            <div className="draggable" onDragStart={ (e) => self.updateDraggingLogo(e, logo) }>
              <img src={ logo.imageUrl } className="city-logo-list" />
            </div>
            <div
              className="droppable"
              onDrop={ (e) => self.droppedAfter(e, logo) }
              onDragOver={ (e) => self.handleDrag(e) }
              style={{ height: '50px' }}
            >
            </div>
          </div>
        );
      };
    });

    if ( logoType == 'current' && result.length == 0 ) {
      result = (
        <div
          className="droppable"
          onDrop={ () => self.dropSelect() }
          onDragOver={ (e) => self.handleDrag(e) }
          style={{ height: '75px' }}
        >
        </div>
      );
    } else if ( logoType == 'available' && result.length == 0 ) {
      result = (
        <div
          className="droppable"
          onDrop={ () => self.dropUnselect() }
          onDragOver={ (e) => self.handleDrag(e) }
          style={{ height: '75px' }}
        >
        </div>
      );
    };

    return result;
  };

  submitLogos() {
    let self    = this;
    let logoIds = [];

    logoIds = this.state.logos.map(function(logo) {
      if ( logo && logo.selected ) return logo.id;
    });

    $.ajax({
      method: "POST",
      url: "cities/set_sponsor_logos",
      data: { parentId: this.props.parentId, logoIds: logoIds }
    })
    .done(function(res) {
      if (res && res.success) {
        self.setState({
          logos: res.logos,
          draggingLogo: null
        });
      } else {
        alert("Something went wrong and the logo could not be added. Try refreshing the page and trying again.");
      }
    });
  };
};

export default SponsorLogoSelector
