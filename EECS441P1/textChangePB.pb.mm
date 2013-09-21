// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: textChangePB.proto

#define INTERNAL_SUPPRESS_PROTOBUF_FIELD_DEPRECATION
#include "textChangePB.pb.h"

#include <algorithm>

#include <google/protobuf/stubs/common.h>
#include <google/protobuf/stubs/once.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/wire_format_lite_inl.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/generated_message_reflection.h>
#include <google/protobuf/reflection_ops.h>
#include <google/protobuf/wire_format.h>
// @@protoc_insertion_point(includes)

namespace textChange {

namespace {

const ::google::protobuf::Descriptor* textChangeMessage_descriptor_ = NULL;
const ::google::protobuf::internal::GeneratedMessageReflection*
  textChangeMessage_reflection_ = NULL;
const ::google::protobuf::EnumDescriptor* textChangeMessage_changeTypeX_descriptor_ = NULL;
const ::google::protobuf::EnumDescriptor* textChangeMessage_messageTriggerX_descriptor_ = NULL;

}  // namespace


void protobuf_AssignDesc_textChangePB_2eproto() {
  protobuf_AddDesc_textChangePB_2eproto();
  const ::google::protobuf::FileDescriptor* file =
    ::google::protobuf::DescriptorPool::generated_pool()->FindFileByName(
      "textChangePB.proto");
  GOOGLE_CHECK(file != NULL);
  textChangeMessage_descriptor_ = file->message_type(0);
  static const int textChangeMessage_offsets_[6] = {
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, senderid_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, changetype_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, messagetrigger_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, cursorlocationstart_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, cursorlocationend_),
    GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, contentmodified_),
  };
  textChangeMessage_reflection_ =
    new ::google::protobuf::internal::GeneratedMessageReflection(
      textChangeMessage_descriptor_,
      textChangeMessage::default_instance_,
      textChangeMessage_offsets_,
      GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, _has_bits_[0]),
      GOOGLE_PROTOBUF_GENERATED_MESSAGE_FIELD_OFFSET(textChangeMessage, _unknown_fields_),
      -1,
      ::google::protobuf::DescriptorPool::generated_pool(),
      ::google::protobuf::MessageFactory::generated_factory(),
      sizeof(textChangeMessage));
  textChangeMessage_changeTypeX_descriptor_ = textChangeMessage_descriptor_->enum_type(0);
  textChangeMessage_messageTriggerX_descriptor_ = textChangeMessage_descriptor_->enum_type(1);
}

namespace {

GOOGLE_PROTOBUF_DECLARE_ONCE(protobuf_AssignDescriptors_once_);
inline void protobuf_AssignDescriptorsOnce() {
  ::google::protobuf::GoogleOnceInit(&protobuf_AssignDescriptors_once_,
                 &protobuf_AssignDesc_textChangePB_2eproto);
}

void protobuf_RegisterTypes(const ::std::string&) {
  protobuf_AssignDescriptorsOnce();
  ::google::protobuf::MessageFactory::InternalRegisterGeneratedMessage(
    textChangeMessage_descriptor_, &textChangeMessage::default_instance());
}

}  // namespace

void protobuf_ShutdownFile_textChangePB_2eproto() {
  delete textChangeMessage::default_instance_;
  delete textChangeMessage_reflection_;
}

void protobuf_AddDesc_textChangePB_2eproto() {
  static bool already_here = false;
  if (already_here) return;
  already_here = true;
  GOOGLE_PROTOBUF_VERIFY_VERSION;

  ::google::protobuf::DescriptorPool::InternalAddGeneratedFile(
    "\n\022textChangePB.proto\022\ntextChange\"\232\003\n\021tex"
    "tChangeMessage\022\020\n\010senderID\030\001 \001(\005\022=\n\nchan"
    "geType\030\002 \001(\0162).textChange.textChangeMess"
    "age.changeTypeX\022E\n\016messageTrigger\030\003 \001(\0162"
    "-.textChange.textChangeMessage.messageTr"
    "iggerX\022\033\n\023cursorLocationStart\030\004 \001(\003\022\031\n\021c"
    "ursorLocationEnd\030\005 \001(\003\022\027\n\017contentModifie"
    "d\030\006 \001(\t\"Y\n\013changeTypeX\022\010\n\004UNDO\020\001\022\010\n\004REDO"
    "\020\002\022\n\n\006INSERT\020\003\022\n\n\006DELETE\020\004\022\020\n\014CURSORCHAN"
    "GE\020\005\022\014\n\010OTHERCTX\020\006\"A\n\017messageTriggerX\022\010\n"
    "\004TIME\020\001\022\013\n\007NUMCHAR\020\002\022\t\n\005SPACE\020\003\022\014\n\010OTHER"
    "MTX\020\004", 445);
  ::google::protobuf::MessageFactory::InternalRegisterGeneratedFile(
    "textChangePB.proto", &protobuf_RegisterTypes);
  textChangeMessage::default_instance_ = new textChangeMessage();
  textChangeMessage::default_instance_->InitAsDefaultInstance();
  ::google::protobuf::internal::OnShutdown(&protobuf_ShutdownFile_textChangePB_2eproto);
}

// Force AddDescriptors() to be called at static initialization time.
struct StaticDescriptorInitializer_textChangePB_2eproto {
  StaticDescriptorInitializer_textChangePB_2eproto() {
    protobuf_AddDesc_textChangePB_2eproto();
  }
} static_descriptor_initializer_textChangePB_2eproto_;

// ===================================================================

const ::google::protobuf::EnumDescriptor* textChangeMessage_changeTypeX_descriptor() {
  protobuf_AssignDescriptorsOnce();
  return textChangeMessage_changeTypeX_descriptor_;
}
bool textChangeMessage_changeTypeX_IsValid(int value) {
  switch(value) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
      return true;
    default:
      return false;
  }
}

#ifndef _MSC_VER
const textChangeMessage_changeTypeX textChangeMessage::UNDO;
const textChangeMessage_changeTypeX textChangeMessage::REDO;
const textChangeMessage_changeTypeX textChangeMessage::INSERT;
const textChangeMessage_changeTypeX textChangeMessage::DELETE;
const textChangeMessage_changeTypeX textChangeMessage::CURSORCHANGE;
const textChangeMessage_changeTypeX textChangeMessage::OTHERCTX;
const textChangeMessage_changeTypeX textChangeMessage::changeTypeX_MIN;
const textChangeMessage_changeTypeX textChangeMessage::changeTypeX_MAX;
const int textChangeMessage::changeTypeX_ARRAYSIZE;
#endif  // _MSC_VER
const ::google::protobuf::EnumDescriptor* textChangeMessage_messageTriggerX_descriptor() {
  protobuf_AssignDescriptorsOnce();
  return textChangeMessage_messageTriggerX_descriptor_;
}
bool textChangeMessage_messageTriggerX_IsValid(int value) {
  switch(value) {
    case 1:
    case 2:
    case 3:
    case 4:
      return true;
    default:
      return false;
  }
}

#ifndef _MSC_VER
const textChangeMessage_messageTriggerX textChangeMessage::TIME;
const textChangeMessage_messageTriggerX textChangeMessage::NUMCHAR;
const textChangeMessage_messageTriggerX textChangeMessage::SPACE;
const textChangeMessage_messageTriggerX textChangeMessage::OTHERMTX;
const textChangeMessage_messageTriggerX textChangeMessage::messageTriggerX_MIN;
const textChangeMessage_messageTriggerX textChangeMessage::messageTriggerX_MAX;
const int textChangeMessage::messageTriggerX_ARRAYSIZE;
#endif  // _MSC_VER
#ifndef _MSC_VER
const int textChangeMessage::kSenderIDFieldNumber;
const int textChangeMessage::kChangeTypeFieldNumber;
const int textChangeMessage::kMessageTriggerFieldNumber;
const int textChangeMessage::kCursorLocationStartFieldNumber;
const int textChangeMessage::kCursorLocationEndFieldNumber;
const int textChangeMessage::kContentModifiedFieldNumber;
#endif  // !_MSC_VER

textChangeMessage::textChangeMessage()
  : ::google::protobuf::Message() {
  SharedCtor();
}

void textChangeMessage::InitAsDefaultInstance() {
}

textChangeMessage::textChangeMessage(const textChangeMessage& from)
  : ::google::protobuf::Message() {
  SharedCtor();
  MergeFrom(from);
}

void textChangeMessage::SharedCtor() {
  _cached_size_ = 0;
  senderid_ = 0;
  changetype_ = 1;
  messagetrigger_ = 1;
  cursorlocationstart_ = GOOGLE_LONGLONG(0);
  cursorlocationend_ = GOOGLE_LONGLONG(0);
  contentmodified_ = const_cast< ::std::string*>(&::google::protobuf::internal::kEmptyString);
  ::memset(_has_bits_, 0, sizeof(_has_bits_));
}

textChangeMessage::~textChangeMessage() {
  SharedDtor();
}

void textChangeMessage::SharedDtor() {
  if (contentmodified_ != &::google::protobuf::internal::kEmptyString) {
    delete contentmodified_;
  }
  if (this != default_instance_) {
  }
}

void textChangeMessage::SetCachedSize(int size) const {
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
}
const ::google::protobuf::Descriptor* textChangeMessage::descriptor() {
  protobuf_AssignDescriptorsOnce();
  return textChangeMessage_descriptor_;
}

const textChangeMessage& textChangeMessage::default_instance() {
  if (default_instance_ == NULL) protobuf_AddDesc_textChangePB_2eproto();
  return *default_instance_;
}

textChangeMessage* textChangeMessage::default_instance_ = NULL;

textChangeMessage* textChangeMessage::New() const {
  return new textChangeMessage;
}

void textChangeMessage::Clear() {
  if (_has_bits_[0 / 32] & (0xffu << (0 % 32))) {
    senderid_ = 0;
    changetype_ = 1;
    messagetrigger_ = 1;
    cursorlocationstart_ = GOOGLE_LONGLONG(0);
    cursorlocationend_ = GOOGLE_LONGLONG(0);
    if (has_contentmodified()) {
      if (contentmodified_ != &::google::protobuf::internal::kEmptyString) {
        contentmodified_->clear();
      }
    }
  }
  ::memset(_has_bits_, 0, sizeof(_has_bits_));
  mutable_unknown_fields()->Clear();
}

bool textChangeMessage::MergePartialFromCodedStream(
    ::google::protobuf::io::CodedInputStream* input) {
#define DO_(EXPRESSION) if (!(EXPRESSION)) return false
  ::google::protobuf::uint32 tag;
  while ((tag = input->ReadTag()) != 0) {
    switch (::google::protobuf::internal::WireFormatLite::GetTagFieldNumber(tag)) {
      // optional int32 senderID = 1;
      case 1: {
        if (::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_VARINT) {
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::int32, ::google::protobuf::internal::WireFormatLite::TYPE_INT32>(
                 input, &senderid_)));
          set_has_senderid();
        } else {
          goto handle_uninterpreted;
        }
        if (input->ExpectTag(16)) goto parse_changeType;
        break;
      }

      // optional .textChange.textChangeMessage.changeTypeX changeType = 2;
      case 2: {
        if (::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_VARINT) {
         parse_changeType:
          int value;
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   int, ::google::protobuf::internal::WireFormatLite::TYPE_ENUM>(
                 input, &value)));
          if (::textChange::textChangeMessage_changeTypeX_IsValid(value)) {
            set_changetype(static_cast< ::textChange::textChangeMessage_changeTypeX >(value));
          } else {
            mutable_unknown_fields()->AddVarint(2, value);
          }
        } else {
          goto handle_uninterpreted;
        }
        if (input->ExpectTag(24)) goto parse_messageTrigger;
        break;
      }

      // optional .textChange.textChangeMessage.messageTriggerX messageTrigger = 3;
      case 3: {
        if (::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_VARINT) {
         parse_messageTrigger:
          int value;
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   int, ::google::protobuf::internal::WireFormatLite::TYPE_ENUM>(
                 input, &value)));
          if (::textChange::textChangeMessage_messageTriggerX_IsValid(value)) {
            set_messagetrigger(static_cast< ::textChange::textChangeMessage_messageTriggerX >(value));
          } else {
            mutable_unknown_fields()->AddVarint(3, value);
          }
        } else {
          goto handle_uninterpreted;
        }
        if (input->ExpectTag(32)) goto parse_cursorLocationStart;
        break;
      }

      // optional int64 cursorLocationStart = 4;
      case 4: {
        if (::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_VARINT) {
         parse_cursorLocationStart:
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::int64, ::google::protobuf::internal::WireFormatLite::TYPE_INT64>(
                 input, &cursorlocationstart_)));
          set_has_cursorlocationstart();
        } else {
          goto handle_uninterpreted;
        }
        if (input->ExpectTag(40)) goto parse_cursorLocationEnd;
        break;
      }

      // optional int64 cursorLocationEnd = 5;
      case 5: {
        if (::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_VARINT) {
         parse_cursorLocationEnd:
          DO_((::google::protobuf::internal::WireFormatLite::ReadPrimitive<
                   ::google::protobuf::int64, ::google::protobuf::internal::WireFormatLite::TYPE_INT64>(
                 input, &cursorlocationend_)));
          set_has_cursorlocationend();
        } else {
          goto handle_uninterpreted;
        }
        if (input->ExpectTag(50)) goto parse_contentModified;
        break;
      }

      // optional string contentModified = 6;
      case 6: {
        if (::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_LENGTH_DELIMITED) {
         parse_contentModified:
          DO_(::google::protobuf::internal::WireFormatLite::ReadString(
                input, this->mutable_contentmodified()));
          ::google::protobuf::internal::WireFormat::VerifyUTF8String(
            this->contentmodified().data(), this->contentmodified().length(),
            ::google::protobuf::internal::WireFormat::PARSE);
        } else {
          goto handle_uninterpreted;
        }
        if (input->ExpectAtEnd()) return true;
        break;
      }

      default: {
      handle_uninterpreted:
        if (::google::protobuf::internal::WireFormatLite::GetTagWireType(tag) ==
            ::google::protobuf::internal::WireFormatLite::WIRETYPE_END_GROUP) {
          return true;
        }
        DO_(::google::protobuf::internal::WireFormat::SkipField(
              input, tag, mutable_unknown_fields()));
        break;
      }
    }
  }
  return true;
#undef DO_
}

void textChangeMessage::SerializeWithCachedSizes(
    ::google::protobuf::io::CodedOutputStream* output) const {
  // optional int32 senderID = 1;
  if (has_senderid()) {
    ::google::protobuf::internal::WireFormatLite::WriteInt32(1, this->senderid(), output);
  }

  // optional .textChange.textChangeMessage.changeTypeX changeType = 2;
  if (has_changetype()) {
    ::google::protobuf::internal::WireFormatLite::WriteEnum(
      2, this->changetype(), output);
  }

  // optional .textChange.textChangeMessage.messageTriggerX messageTrigger = 3;
  if (has_messagetrigger()) {
    ::google::protobuf::internal::WireFormatLite::WriteEnum(
      3, this->messagetrigger(), output);
  }

  // optional int64 cursorLocationStart = 4;
  if (has_cursorlocationstart()) {
    ::google::protobuf::internal::WireFormatLite::WriteInt64(4, this->cursorlocationstart(), output);
  }

  // optional int64 cursorLocationEnd = 5;
  if (has_cursorlocationend()) {
    ::google::protobuf::internal::WireFormatLite::WriteInt64(5, this->cursorlocationend(), output);
  }

  // optional string contentModified = 6;
  if (has_contentmodified()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8String(
      this->contentmodified().data(), this->contentmodified().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE);
    ::google::protobuf::internal::WireFormatLite::WriteString(
      6, this->contentmodified(), output);
  }

  if (!unknown_fields().empty()) {
    ::google::protobuf::internal::WireFormat::SerializeUnknownFields(
        unknown_fields(), output);
  }
}

::google::protobuf::uint8* textChangeMessage::SerializeWithCachedSizesToArray(
    ::google::protobuf::uint8* target) const {
  // optional int32 senderID = 1;
  if (has_senderid()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteInt32ToArray(1, this->senderid(), target);
  }

  // optional .textChange.textChangeMessage.changeTypeX changeType = 2;
  if (has_changetype()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteEnumToArray(
      2, this->changetype(), target);
  }

  // optional .textChange.textChangeMessage.messageTriggerX messageTrigger = 3;
  if (has_messagetrigger()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteEnumToArray(
      3, this->messagetrigger(), target);
  }

  // optional int64 cursorLocationStart = 4;
  if (has_cursorlocationstart()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteInt64ToArray(4, this->cursorlocationstart(), target);
  }

  // optional int64 cursorLocationEnd = 5;
  if (has_cursorlocationend()) {
    target = ::google::protobuf::internal::WireFormatLite::WriteInt64ToArray(5, this->cursorlocationend(), target);
  }

  // optional string contentModified = 6;
  if (has_contentmodified()) {
    ::google::protobuf::internal::WireFormat::VerifyUTF8String(
      this->contentmodified().data(), this->contentmodified().length(),
      ::google::protobuf::internal::WireFormat::SERIALIZE);
    target =
      ::google::protobuf::internal::WireFormatLite::WriteStringToArray(
        6, this->contentmodified(), target);
  }

  if (!unknown_fields().empty()) {
    target = ::google::protobuf::internal::WireFormat::SerializeUnknownFieldsToArray(
        unknown_fields(), target);
  }
  return target;
}

int textChangeMessage::ByteSize() const {
  int total_size = 0;

  if (_has_bits_[0 / 32] & (0xffu << (0 % 32))) {
    // optional int32 senderID = 1;
    if (has_senderid()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::Int32Size(
          this->senderid());
    }

    // optional .textChange.textChangeMessage.changeTypeX changeType = 2;
    if (has_changetype()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::EnumSize(this->changetype());
    }

    // optional .textChange.textChangeMessage.messageTriggerX messageTrigger = 3;
    if (has_messagetrigger()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::EnumSize(this->messagetrigger());
    }

    // optional int64 cursorLocationStart = 4;
    if (has_cursorlocationstart()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::Int64Size(
          this->cursorlocationstart());
    }

    // optional int64 cursorLocationEnd = 5;
    if (has_cursorlocationend()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::Int64Size(
          this->cursorlocationend());
    }

    // optional string contentModified = 6;
    if (has_contentmodified()) {
      total_size += 1 +
        ::google::protobuf::internal::WireFormatLite::StringSize(
          this->contentmodified());
    }

  }
  if (!unknown_fields().empty()) {
    total_size +=
      ::google::protobuf::internal::WireFormat::ComputeUnknownFieldsSize(
        unknown_fields());
  }
  GOOGLE_SAFE_CONCURRENT_WRITES_BEGIN();
  _cached_size_ = total_size;
  GOOGLE_SAFE_CONCURRENT_WRITES_END();
  return total_size;
}

void textChangeMessage::MergeFrom(const ::google::protobuf::Message& from) {
  GOOGLE_CHECK_NE(&from, this);
  const textChangeMessage* source =
    ::google::protobuf::internal::dynamic_cast_if_available<const textChangeMessage*>(
      &from);
  if (source == NULL) {
    ::google::protobuf::internal::ReflectionOps::Merge(from, this);
  } else {
    MergeFrom(*source);
  }
}

void textChangeMessage::MergeFrom(const textChangeMessage& from) {
  GOOGLE_CHECK_NE(&from, this);
  if (from._has_bits_[0 / 32] & (0xffu << (0 % 32))) {
    if (from.has_senderid()) {
      set_senderid(from.senderid());
    }
    if (from.has_changetype()) {
      set_changetype(from.changetype());
    }
    if (from.has_messagetrigger()) {
      set_messagetrigger(from.messagetrigger());
    }
    if (from.has_cursorlocationstart()) {
      set_cursorlocationstart(from.cursorlocationstart());
    }
    if (from.has_cursorlocationend()) {
      set_cursorlocationend(from.cursorlocationend());
    }
    if (from.has_contentmodified()) {
      set_contentmodified(from.contentmodified());
    }
  }
  mutable_unknown_fields()->MergeFrom(from.unknown_fields());
}

void textChangeMessage::CopyFrom(const ::google::protobuf::Message& from) {
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

void textChangeMessage::CopyFrom(const textChangeMessage& from) {
  if (&from == this) return;
  Clear();
  MergeFrom(from);
}

bool textChangeMessage::IsInitialized() const {

  return true;
}

void textChangeMessage::Swap(textChangeMessage* other) {
  if (other != this) {
    std::swap(senderid_, other->senderid_);
    std::swap(changetype_, other->changetype_);
    std::swap(messagetrigger_, other->messagetrigger_);
    std::swap(cursorlocationstart_, other->cursorlocationstart_);
    std::swap(cursorlocationend_, other->cursorlocationend_);
    std::swap(contentmodified_, other->contentmodified_);
    std::swap(_has_bits_[0], other->_has_bits_[0]);
    _unknown_fields_.Swap(&other->_unknown_fields_);
    std::swap(_cached_size_, other->_cached_size_);
  }
}

::google::protobuf::Metadata textChangeMessage::GetMetadata() const {
  protobuf_AssignDescriptorsOnce();
  ::google::protobuf::Metadata metadata;
  metadata.descriptor = textChangeMessage_descriptor_;
  metadata.reflection = textChangeMessage_reflection_;
  return metadata;
}


// @@protoc_insertion_point(namespace_scope)

}  // namespace textChange

// @@protoc_insertion_point(global_scope)
