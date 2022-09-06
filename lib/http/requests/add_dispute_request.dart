class AddDisputeRequest {
  final String disputeType;
  final String description;
  final int jobId;
  final int memberId;
  final String amount;
  final String memberDeviceId;

  AddDisputeRequest(
      {required this.disputeType,
      required this.description,
      required this.jobId,
      required this.memberDeviceId,
      required this.amount,
      required this.memberId});

  Map<String, dynamic> toJson() => {
        "dispute_type": disputeType,
        "description": description,
        "job_id": jobId,
        "amount": amount,
        "member_id": memberId,
        "member_device_id": memberDeviceId
      };
}
