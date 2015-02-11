/** @jsx React.DOM */

var CommentList = React.createClass({

  getInitialState: function () {
    return {
      comments: CommentStore.sortByRating( this.props.comments )
    }
  },

  componentWillReceiveProps: function ( props ) {
    this.setState({ comments: props.comments });
  },

  componentDidMount: function () {
    CommentStore.addChangeListener( this._onChange );
  },

  componentWillUnmount: function () {
    CommentStore.removeChangeListener( this._onChange );
  },

  componentDidUpdate: function () {
    var comment;

    if ( this.state.newComment ) {
      comment = document.querySelector(
        '.comment-component[data-key="' + this.state.newComment.id + '"]'
      );
      window.scroll( 0, comment.offsetTop - comment.clientHeight );
    }
  },

  collectComments: function () {
    return this.state.comments.map( function ( comment ) {
      return <Comment comment={ comment } key={ comment.id } />;
    });
  },

  render: function () {
    return (
      <div className="comment-list-component">
        { this.collectComments() }
      </div>
    );
  },

  // private

  _onChange: function () {
    var comments = CommentStore.getAllAsList(), match = false, newComment;

    for( var j = 0; j < comments.length; j++ ) {
      match = false;

      for( var i = 0; i < this.state.comments.length; i++){
        if ( comments[j].id === this.state.comments[i].id ) {
          match = true;
          break;
        }
      }

      if ( match ) continue;

      newComment = comments[i];
      break;
    }

    this.setState({
      comments: comments,
      newComment: newComment
    });
  }
});