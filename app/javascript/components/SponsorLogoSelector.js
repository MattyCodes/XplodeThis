import React from "react"
import PropTypes from "prop-types"

class SponsorLogoSelector extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentLogos: this.props.currentLogos,
      availableLogos: this.props.availableLogos
    };
  };

  render () {
    var currentLogos   = this.generateList('current');
    var availableLogos = this.generateList('available');

    return (
      <div className="row">
        <div className="col-xs-12 col-sm-6 col-md-6 col-lg-6">
          { currentLogos }
        </div>
        <div className="col-xs-12 col-sm-6 col-md-6 col-lg-6">
          { availableLogos }
        </div>
      </div>
    );
  };

  generateList(logoType) {
    var self   = this;
    var logos  = ( logoType == 'current' ? this.state.currentLogos : this.state.availableLogos );
    var result = logos.map(function(logo) {
      return (<div key={ logoType + logo.id } style={{ margin: "40px auto 20px auto" }}>
                <img src={ logo.imageUrl } className="city-logo-list"/>
                { self.generateButton(self, logoType, logo.id) }
              </div>);
    });

    return result;
  };

  removeLogo(e, logoId) {
    e.preventDefault();
    let self = this;

    $.ajax({
      method: "POST",
      url: "/cities/remove_sponsor_logo",
      data: { parentId: this.props.parentId, logoId: logoId }
    })
    .done(function(res) {
      if (res && res.success) {
        self.setState({
          currentLogos: res.currentLogos,
          availableLogos: res.availableLogos
        });
      } else {
        alert("Something went wrong and the logo could not be removed. Try refreshing the page and trying again.");
      }
    });
  };

  addLogo(e, logoId) {
    e.preventDefault();
    let self = this;

    $.ajax({
      method: "POST",
      url: "/cities/add_sponsor_logo",
      data: { parentId: this.props.parentId, logoId: logoId }
    })
    .done(function(res) {
      if (res && res.success) {
        self.setState({
          currentLogos: res.currentLogos,
          availableLogos: res.availableLogos
        });
      } else {
        alert("Something went wrong and the logo could not be added. Try refreshing the page and trying again.");
      }
    });
  };

  generateButton(self, logoType, id) {
    return ( logoType == 'current' ? <button onClick={ (e) => self.removeLogo(e, id) } className="btn btn-rounded btn-danger" style={{ display: "block", margin: '20px auto', padding: '7px 25px' }}> Remove Logo </button> : <button onClick={ (e) => self.addLogo(e, id) } className="btn btn-rounded btn-info" style={{ display: "block", margin: '20px auto', padding: '7px 25px' }}> Add Logo </button> );
  };
};

export default SponsorLogoSelector
