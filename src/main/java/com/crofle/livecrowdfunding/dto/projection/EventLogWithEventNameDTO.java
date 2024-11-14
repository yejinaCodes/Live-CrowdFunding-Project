package com.crofle.livecrowdfunding.dto.projection;

import com.crofle.livecrowdfunding.domain.entity.EventLog;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EventLogWithEventNameDTO {
    private EventLog eventLog;
    private String eventName;
}
