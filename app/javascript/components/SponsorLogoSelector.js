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
          <button className="btn btn-lg btn-primary btn-rounded" onClick={ (e) => this.submitLogos(e) }>
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

    this.setState({ logos: ( theseLogos.concat(thoseLogos) ), draggingLogo: null });
  };

  droppedEnd(selected) {
    let logo        = this.state.draggingLogo;
    let logos       = this.state.logos;
    let removeIndex = logos.indexOf(logo);

    logo['selected'] = selected;
    logos.splice(removeIndex, 1);
    logos.push(logo);

    this.setState({ logos: logos });
  };

  dropSelect() {
    let thisLogo = this.state.draggingLogo;
    let logos    = this.state.logos;

    logos.map(function(logo) {
      if ( logo.id == thisLogo.id ) logo.selected = true;
    });

    this.setState({ logos: logos });
  };

  dropUnselect() {
    let thisLogo = this.state.draggingLogo;
    let logos    = this.state.logos;

    logos.map(function(logo) {
      if ( logo.id == thisLogo.id ) logo.selected = false;
    });

    this.setState({ logos: logos });
  };

  generateList(logoType) {
    var self        = this;
    var logos       = this.state.logos;
    var selected    = false;
    var available   = false;
    var hasValues   = false;
    var endDropZone = null;
    var result      = logos.map(function(logo, index) {
      selected  = ( logo && logoType == 'current' && logo.selected );
      available = ( logo && logoType == 'available' && !logo.selected );

      if ( selected || available ) {
        return (
          <div key={ logoType + logo.id + index }>
            <div
              className="droppable"
              onDrop={ (e) => self.droppedBefore(e, logo) }
              onDragOver={ (e) => self.handleDrag(e) }
              style={{ height: '75px' }}
            >
            </div>
            <div className="draggable" onDragStart={ (e) => self.updateDraggingLogo(e, logo) }>
              <img src={ logo.imageUrl } className="city-logo-list" />
            </div>
          </div>
        );
      };
    });

    result.map(function(res) {
      if ( res ) hasValues = true;
    });

    if ( logoType == 'current' && !hasValues ) {
      result = (
        <div
          className="droppable"
          onDrop={ () => self.dropSelect() }
          onDragOver={ (e) => self.handleDrag(e) }
          style={{ height: '75px' }}
        >
        </div>
      );
    } else if ( logoType == 'available' && !hasValues ) {
      result = (
        <div
          className="droppable"
          onDrop={ () => self.dropUnselect() }
          onDragOver={ (e) => self.handleDrag(e) }
          style={{ height: '75px' }}
        >
        </div>
      );
    } else if ( hasValues ) {
      selected    = ( logoType == 'current' ? true : false );
      endDropZone = (
        <div
          className="droppable"
          onDrop={ () => self.droppedEnd(selected) }
          onDragOver={ (e) => self.handleDrag(e) }
          style={{ height: '75px' }}
          key={ 'end-drop-zone-' + hasValues }
        >
        </div>
      );

      result.push(endDropZone)
    };

    return result;
  };

  submitLogos(e) {
    e.preventDefault();

    let self    = this;
    let logoIds = [];
    let url     = '/cities/set_sponsor_logos';

    if ( this.props.parentType == 'home' ) {
      url = 'order_home_logos';
    };

    logoIds = this.state.logos.map(function(logo) {
      if ( logo && logo.selected ) return logo.id;
    });

    $.ajax({
      method: "POST",
      url: url,
      data: { parentId: this.props.parentId, logoIds: logoIds }
    })
    .done(function(res) {
      if (res && res.success) {
        self.setState({
          logos: res.logos,
          draggingLogo: null
        });

        alert("Logos have been updated!");
      } else {
        alert("Something went wrong and the logos could not be updated. Try refreshing the page and trying again.");
      }
    });
  };
};

export default SponsorLogoSelector
